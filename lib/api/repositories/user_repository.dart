import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_profile.dart';

/// Manages the user profile document and favourites list.
/// Firestore path: users/{uid}
class UserRepository {
  UserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _ref(String uid) =>
      _firestore.collection('users').doc(uid);

  Stream<UserProfile> watchProfile(String uid) {
    return _ref(uid).snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) {
        return UserProfile(userId: uid);
      }
      return UserProfile.fromJson({...snap.data()!, 'userId': uid});
    });
  }

  Future<UserProfile> getProfile(String uid) async {
    final snap = await _ref(uid).get();
    if (!snap.exists || snap.data() == null) {
      return UserProfile(userId: uid);
    }
    return UserProfile.fromJson({...snap.data()!, 'userId': uid});
  }

  Future<void> createProfile(UserProfile profile) async {
    await _ref(profile.userId).set(
      profile.toJson()..remove('userId'),
      SetOptions(merge: true),
    );
  }

  Future<void> addFavourite(String uid, String wordId) async {
    await _ref(uid).update({
      'favouriteWordIds': FieldValue.arrayUnion([wordId]),
    });
  }

  Future<void> removeFavourite(String uid, String wordId) async {
    await _ref(uid).update({
      'favouriteWordIds': FieldValue.arrayRemove([wordId]),
    });
  }

  Future<void> setLanguage(String uid, String languageId) async {
    await _ref(uid).set(
      {'currentLanguageId': languageId},
      SetOptions(merge: true),
    );
  }
}
