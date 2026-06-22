import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/word_usage.dart';

/// Stores per-user word usage counts in Firestore.
/// Firestore path: users/{uid}/wordUsage/{wordId}
///
/// Uses FieldValue.increment so writes are atomic and work offline —
/// Firestore queues them and applies when connectivity is restored.
class WordUsageRepository {
  WordUsageRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _ref(String uid) =>
      _firestore.collection('users').doc(uid).collection('wordUsage');

  /// Increments the count for [wordId] by 1. Fire-and-forget.
  Future<void> increment(String uid, String wordId) {
    return _ref(uid).doc(wordId).set(
      {
        'wordId': wordId,
        'count': FieldValue.increment(1),
        'lastUsed': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  /// Top [limit] most-used words, ordered by count descending.
  Stream<List<WordUsage>> watchTopWords(String uid, {int limit = 20}) {
    return _ref(uid)
        .orderBy('count', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => WordUsage.fromJson(d.data())).toList());
  }

  Stream<List<WordUsage>> watchAll(String uid) {
    return _ref(uid)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => WordUsage.fromJson(d.data())).toList());
  }
}
