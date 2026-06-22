import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/word_group.dart';

/// User-created phrase cards (word groups).
/// Firestore path: users/{uid}/wordGroups/{groupId}
class WordGroupRepository {
  WordGroupRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _ref(String uid) =>
      _firestore.collection('users').doc(uid).collection('wordGroups');

  Stream<List<WordGroup>> watchAll(String uid) {
    return _ref(uid)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => WordGroup.fromJson(d.data())).toList());
  }

  Future<void> save(String uid, WordGroup group) async {
    await _ref(uid).doc(group.id).set(group.toJson());
  }

  Future<void> delete(String uid, String groupId) async {
    await _ref(uid).doc(groupId).delete();
  }

  Future<void> incrementUsage(String uid, String groupId) {
    return _ref(uid).doc(groupId).update({
      'usageCount': FieldValue.increment(1),
    });
  }
}
