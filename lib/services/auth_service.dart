import 'package:firebase_auth/firebase_auth.dart';

/// Provides a stable userId via Firebase anonymous auth.
/// The user never sees a sign-in screen — auth is transparent.
/// Later we can offer "link account" to persist data across reinstalls.
class AuthService {
  AuthService(this._auth);

  final FirebaseAuth _auth;

  String? get currentUserId => _auth.currentUser?.uid;

  bool get isSignedIn => _auth.currentUser != null;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Signs in anonymously if not already signed in.
  Future<String> ensureSignedIn() async {
    if (_auth.currentUser != null) return _auth.currentUser!.uid;
    final credential = await _auth.signInAnonymously();
    return credential.user!.uid;
  }
}
