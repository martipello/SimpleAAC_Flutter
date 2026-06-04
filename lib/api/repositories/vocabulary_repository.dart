import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../models/language.dart';
import '../models/language_response.dart';
import '../models/word.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';

/// Loads core vocabulary from bundled JSON assets.
/// User-added custom words are stored per-user in Firestore.
class VocabularyRepository {
  VocabularyRepository(this._firestore);

  final FirebaseFirestore _firestore;

  // In-memory cache of the bundled word library, keyed by languageId.
  final Map<String, Language> _coreCache = {};

  // ---------------------------------------------------------------------------
  // Core vocabulary (bundled asset)
  // ---------------------------------------------------------------------------

  Future<void> loadCoreVocabulary() async {
    if (_coreCache.isNotEmpty) return;
    final raw =
        await rootBundle.loadString('assets/json/initial_word_data.json');
    final response = LanguageResponse.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
    for (final language in response.languages) {
      _coreCache[language.id] = language;
    }
  }

  List<Word> getCoreWordsForSubType(String languageId, WordSubType subType) {
    final language = _coreCache[languageId];
    if (language == null) return [];
    return language.words.where((w) => w.subType == subType).toList();
  }

  List<Word> getCoreWordsForType(String languageId, WordType type) {
    final language = _coreCache[languageId];
    if (language == null) return [];
    return language.words.where((w) => w.type == type).toList();
  }

  List<Word> getCoreWordsForIds(String languageId, List<String> ids) {
    final language = _coreCache[languageId];
    if (language == null) return [];
    final idSet = ids.toSet();
    return language.words.where((w) => idSet.contains(w.wordId)).toList();
  }

  List<Language> getAllLanguages() => _coreCache.values.toList();

  List<Word> getAllCoreWordsForLanguage(String languageId) =>
      _coreCache[languageId]?.words ?? [];

  List<Word> searchWords(String languageId, String query) {
    final language = _coreCache[languageId];
    if (language == null) return [];
    return language.words
        .where((w) => w.text.toLowerCase().contains(query))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Custom words (Firestore, per user)
  // Firestore path: users/{uid}/customWords/{wordId}
  // ---------------------------------------------------------------------------

  CollectionReference<Map<String, dynamic>> _customWordsRef(String uid) =>
      _firestore.collection('users').doc(uid).collection('customWords');

  Future<void> saveCustomWord(String uid, Word word) async {
    await _customWordsRef(uid).doc(word.wordId).set(word.toJson());
  }

  Future<void> deleteCustomWord(String uid, String wordId) async {
    await _customWordsRef(uid).doc(wordId).delete();
  }

  Stream<List<Word>> watchCustomWords(String uid) {
    return _customWordsRef(uid).snapshots().map(
          (snap) => snap.docs
              .map((d) => Word.fromJson(d.data()))
              .toList(),
        );
  }

  // ---------------------------------------------------------------------------
  // Combined stream (core + custom) for a given subType
  // ---------------------------------------------------------------------------

  Stream<List<Word>> watchFavourites(String uid, String languageId) {
    final allCore = _coreCache[languageId]?.words ?? [];
    final coreFavs = BehaviorSubject<List<Word>>.seeded(
      allCore.where((w) => w.isFavourite).toList(),
    );
    return Rx.combineLatest2<List<Word>, List<Word>, List<Word>>(
      coreFavs,
      watchCustomWords(uid).map((all) => all.where((w) => w.isFavourite).toList()),
      (core, custom) {
        // Custom words override core words of the same ID
        final customIds = custom.map((w) => w.wordId).toSet();
        return [...core.where((w) => !customIds.contains(w.wordId)), ...custom];
      },
    );
  }

  Stream<List<Word>> watchWordsForSubType(
    String uid,
    String languageId,
    WordSubType subType,
  ) {
    if (subType == WordSubType.favourites) {
      return watchFavourites(uid, languageId);
    }

    final coreWords =
        BehaviorSubject<List<Word>>.seeded(getCoreWordsForSubType(languageId, subType));

    return Rx.combineLatest2<List<Word>, List<Word>, List<Word>>(
      coreWords,
      watchCustomWords(uid).map(
        (all) => all.where((w) => w.subType == subType).toList(),
      ),
      (core, custom) => [...core, ...custom],
    );
  }

  Stream<List<Word>> watchWordsForType(
    String uid,
    String languageId,
    WordType type,
  ) {
    final coreWords =
        BehaviorSubject<List<Word>>.seeded(getCoreWordsForType(languageId, type));

    return Rx.combineLatest2<List<Word>, List<Word>, List<Word>>(
      coreWords,
      watchCustomWords(uid).map(
        (all) => all.where((w) => w.type == type).toList(),
      ),
      (core, custom) => [...core, ...custom],
    );
  }
}
