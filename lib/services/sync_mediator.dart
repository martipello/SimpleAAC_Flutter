import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' show Value;
import 'package:firebase_auth/firebase_auth.dart';

import '../api/models/word.dart';
import '../api/models/word_group.dart';
import '../api/models/word_usage.dart';
import '../api/models/word_sub_type.dart';
import '../api/models/word_type.dart';
import '../database/app_database.dart';
import '../database/daos/sync_dao.dart';
import 'auth_service.dart';
import 'shared_preferences_service.dart';

/// How long cached core vocabulary is considered fresh before re-fetching.
const _vocabCacheTtl = Duration(days: 7);

/// Bridges Firebase (two remote sources) and the local Drift database.
///
/// Data flow:
///   Firebase core vocab  ──┐
///                          ├─► SyncMediator ─► Local DB ─► UI
///   Firebase user data  ───┘
///
/// The UI never reads from Firebase directly. All writes go to local DB
/// first (immediate UI update), then propagate to Firebase asynchronously.
class SyncMediator {
  SyncMediator({
    required FirebaseFirestore firestore,
    required AuthService auth,
    required SharedPreferencesService prefs,
    required WordsDao wordsDao,
    required WordGroupsDao wordGroupsDao,
    required WordUsageDao wordUsageDao,
    required SyncDao syncDao,
  })  : _firestore = firestore,
        _auth = auth,
        _prefs = prefs,
        _wordsDao = wordsDao,
        _wordGroupsDao = wordGroupsDao,
        _wordUsageDao = wordUsageDao,
        _syncDao = syncDao;

  final FirebaseFirestore _firestore;
  final AuthService _auth;
  final SharedPreferencesService _prefs;
  final WordsDao _wordsDao;
  final WordGroupsDao _wordGroupsDao;
  final WordUsageDao _wordUsageDao;
  final SyncDao _syncDao;

  StreamSubscription<User?>? _authSub;
  StreamSubscription<QuerySnapshot>? _overridesSub;
  StreamSubscription<QuerySnapshot>? _groupsSub;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  /// Call once from app startup. Reacts to auth state changes automatically.
  Future<void> start() async {
    // Ensure we have an anonymous session so Firestore rules allow core vocab reads.
    await _auth.ensureSignedIn();

    // Sync core vocab for current language immediately using whatever auth we have.
    await _ensureCoreVocabFresh(_prefs.currentLanguageId);

    // React to auth changes (anonymous → linked, sign-out, etc.)
    _authSub = _auth.authStateChanges.listen(_onAuthChanged);

    // If already authenticated, start user sync now.
    final uid = _auth.currentUserId;
    if (uid != null) _startUserSync(uid);
  }

  /// Call when the user selects a different language.
  Future<void> onLanguageChanged(String languageId) =>
      _ensureCoreVocabFresh(languageId);

  void dispose() {
    _authSub?.cancel();
    _stopUserSync();
  }

  // ── Auth handling ─────────────────────────────────────────────────────────

  void _onAuthChanged(User? user) {
    if (user == null) {
      _stopUserSync();
    } else {
      _startUserSync(user.uid);
    }
  }

  // ── Core vocabulary ───────────────────────────────────────────────────────

  Future<void> _ensureCoreVocabFresh(String languageId) async {
    final key = SyncCollection.vocabulary(languageId);
    final lastSync = await _syncDao.getLastSyncedAt(key);
    final isFresh = lastSync != null &&
        DateTime.now().difference(lastSync) < _vocabCacheTtl;

    if (isFresh) return;

    await _fetchCoreVocabulary(languageId);
  }

  Future<void> _fetchCoreVocabulary(String languageId) async {
    final snap = await _firestore
        .collection('vocabulary')
        .doc(languageId)
        .collection('words')
        .get();

    if (snap.docs.isEmpty) return;

    final companions = snap.docs
        .map((doc) => _coreWordCompanion(doc.data(), languageId))
        .whereType<WordsTableCompanion>()
        .toList();

    await _wordsDao.upsertCoreWords(companions);
    await _syncDao.markSynced(SyncCollection.vocabulary(languageId));
  }

  WordsTableCompanion? _coreWordCompanion(
    Map<String, dynamic> data,
    String languageId,
  ) {
    try {
      return WordsTableCompanion(
        wordId: Value(data['wordId'] as String),
        languageId: Value(languageId),
        wordText: Value(data['text'] as String),
        phoneticOverride: Value(data['phoneticOverride'] as String?),
        type: Value(WordType.values.byName(data['type'] as String)),
        subType: Value(WordSubType.values.byName(data['subType'] as String)),
        imagePath: Value(data['imagePath'] as String?),
        extraRelatedWordIds: Value(
          (data['extraRelatedWordIds'] as List?)?.cast<String>() ?? [],
        ),
        aiSuggestedFollowUps: Value(
          (data['aiSuggestedFollowUps'] as List?)?.cast<String>() ?? [],
        ),
        createdDate: Value(null),
      );
    } catch (_) {
      // Skip malformed documents rather than crashing the whole sync.
      return null;
    }
  }

  // ── User data (real-time) ─────────────────────────────────────────────────

  void _startUserSync(String uid) {
    _stopUserSync();

    _overridesSub = _firestore
        .collection('users')
        .doc(uid)
        .collection('wordOverrides')
        .snapshots()
        .listen(_onOverridesSnapshot);

    _groupsSub = _firestore
        .collection('users')
        .doc(uid)
        .collection('wordGroups')
        .snapshots()
        .listen(_onGroupsSnapshot);
  }

  void _stopUserSync() {
    _overridesSub?.cancel();
    _groupsSub?.cancel();
    _overridesSub = null;
    _groupsSub = null;
  }

  void _onOverridesSnapshot(QuerySnapshot snap) {
    for (final change in snap.docChanges) {
      final wordId = change.doc.id;
      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          final data = change.doc.data()! as Map<String, dynamic>;
          _wordsDao.upsertOverride(_overrideCompanion(wordId, data));
          // Usage is stored on the same document alongside override fields.
          final count = (data['count'] as num?)?.toInt();
          if (count != null) {
            _wordUsageDao.upsertAll([
              WordUsage(
                wordId: wordId,
                count: count,
                lastUsed: _tsToDateTime(data['lastUsed']),
              ),
            ]);
          }
        case DocumentChangeType.removed:
          _wordsDao.deleteOverride(wordId);
      }
    }
  }

  void _onGroupsSnapshot(QuerySnapshot snap) {
    for (final change in snap.docChanges) {
      switch (change.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          final data = change.doc.data()! as Map<String, dynamic>;
          final group = WordGroup.fromJson(data);
          _wordGroupsDao.upsert(group);
        case DocumentChangeType.removed:
          _wordGroupsDao.deleteGroup(change.doc.id);
      }
    }
  }

  // ── Write operations (local-first, then Firebase) ─────────────────────────

  /// Marks or unmarks a word as a favourite.
  Future<void> setWordFavourite(String wordId, {required bool isFavourite}) async {
    // Local DB: sparse upsert — only touch isFavourite.
    await _wordsDao.upsertOverride(
      WordOverridesTableCompanion(
        wordId: Value(wordId),
        isFavourite: Value(isFavourite),
        updatedAt: Value(DateTime.now()),
      ),
    );

    // Firebase: merge so other override fields are untouched.
    _userOverridesRef(wordId)
        ?.set({'isFavourite': isFavourite}, SetOptions(merge: true));
  }

  /// Sentinel exposed so callers can signal "field unchanged — do not write".
  static const absent = Object();

  /// Applies one or more field overrides to a core word.
  /// Pass [absent] for a field to leave it untouched.
  /// Pass null for a field to explicitly clear that override (revert to core).
  Future<void> applyWordOverride(
    String wordId, {
    Object? wordText = absent,
    Object? phoneticOverride = absent,
    Object? type = absent,
    Object? subType = absent,
    Object? imagePath = absent,
  }) async {
    final companion = WordOverridesTableCompanion(
      wordId: Value(wordId),
      wordText: wordText == absent
          ? const Value.absent()
          : Value(wordText as String?),
      phoneticOverride: phoneticOverride == absent
          ? const Value.absent()
          : Value(phoneticOverride as String?),
      type: type == absent ? const Value.absent() : Value(type as String?),
      subType:
          subType == absent ? const Value.absent() : Value(subType as String?),
      imagePath: imagePath == absent
          ? const Value.absent()
          : Value(imagePath as String?),
      updatedAt: Value(DateTime.now()),
    );

    await _wordsDao.upsertOverride(companion);

    // Build the Firestore patch — only the fields that were explicitly passed.
    final patch = <String, dynamic>{};
    if (wordText != absent) patch['text'] = wordText;
    if (phoneticOverride != absent) patch['phoneticOverride'] = phoneticOverride;
    if (type != absent) patch['type'] = type;
    if (subType != absent) patch['subType'] = subType;
    if (imagePath != absent) patch['imagePath'] = imagePath;

    if (patch.isNotEmpty) {
      _userOverridesRef(wordId)?.set(patch, SetOptions(merge: true));
    }
  }

  Future<void> saveWordGroup(WordGroup group) async {
    await _wordGroupsDao.upsert(group);
    _userRef()
        ?.collection('wordGroups')
        .doc(group.id)
        .set(group.toJson());
  }

  Future<void> deleteWordGroup(String groupId) async {
    await _wordGroupsDao.deleteGroup(groupId);
    _userRef()?.collection('wordGroups').doc(groupId).delete();
  }

  /// Upserts a user-created word into the local DB and propagates to Firebase.
  Future<void> saveWord(Word word, String languageId) async {
    final companion = WordsTableCompanion(
      wordId: Value(word.wordId),
      languageId: Value(languageId),
      wordText: Value(word.text),
      phoneticOverride: Value(word.phoneticOverride),
      type: Value(word.type),
      subType: Value(word.subType),
      imagePath: Value(word.imagePath),
      extraRelatedWordIds: Value(word.extraRelatedWordIds),
      aiSuggestedFollowUps: Value(word.aiSuggestedFollowUps),
      localEmbedding: Value(word.localEmbedding),
      createdDate: Value(word.createdDate ?? DateTime.now()),
    );
    await _wordsDao.upsertCoreWords([companion]);

    _userRef()?.collection('customWords').doc(word.wordId).set({
      'wordId': word.wordId,
      'languageId': languageId,
      'text': word.text,
      'phoneticOverride': word.phoneticOverride,
      'type': word.type.name,
      'subType': word.subType.name,
      'imagePath': word.imagePath,
    }, SetOptions(merge: true));
  }

  /// Removes a user-created word from the local DB and Firebase.
  Future<void> deleteWord(String wordId) async {
    await _wordsDao.deleteWord(wordId);
    await _wordsDao.deleteOverride(wordId);
    _userRef()?.collection('customWords').doc(wordId).delete();
  }

  Future<void> incrementWordUsage(String wordId) async {
    await _wordUsageDao.increment(wordId);
    // Usage lives on the same wordOverrides document — merge so override fields are untouched.
    _userOverridesRef(wordId)?.set(
      {
        'count': FieldValue.increment(1),
        'lastUsed': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────


  DocumentReference? _userRef() {
    final uid = _auth.currentUserId;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid);
  }

  DocumentReference? _userOverridesRef(String wordId) =>
      _userRef()?.collection('wordOverrides').doc(wordId);

  WordOverridesTableCompanion _overrideCompanion(
    String wordId,
    Map<String, dynamic> data,
  ) {
    // The Firestore document is the canonical state for this word's overrides.
    // A field absent from the document means "no override" (null in local DB).
    return WordOverridesTableCompanion(
      wordId: Value(wordId),
      isFavourite: Value(data['isFavourite'] as bool?),
      wordText: Value(data['text'] as String?),
      phoneticOverride: Value(data['phoneticOverride'] as String?),
      type: Value(data['type'] as String?),
      subType: Value(data['subType'] as String?),
      imagePath: Value(data['imagePath'] as String?),
      updatedAt: Value(_tsToDateTime(data['updatedAt']) ?? DateTime.now()),
    );
  }

  DateTime? _tsToDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    return null;
  }
}
