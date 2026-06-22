import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService(this._auth);

  final FirebaseAuth _auth;
  final _googleSignIn = GoogleSignIn();

  String? get currentUserId => _auth.currentUser?.uid;

  bool get isSignedIn => _auth.currentUser != null;

  bool get isAnonymous => _auth.currentUser?.isAnonymous ?? true;

  bool get isSignedInWithGoogle =>
      _auth.currentUser?.providerData.any((p) => p.providerId == 'google.com') ?? false;

  String? get displayName => _auth.currentUser?.displayName;

  String? get email => _auth.currentUser?.email;

  String? get photoUrl => _auth.currentUser?.photoURL;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Stream<User?> get idTokenChanges => _auth.idTokenChanges();

  /// Signs in anonymously if not already signed in.
  Future<String> ensureSignedIn() async {
    if (_auth.currentUser != null) return _auth.currentUser!.uid;
    final credential = await _auth.signInAnonymously();
    return credential.user!.uid;
  }

  /// Signs out and immediately re-establishes an anonymous session so the
  /// app always has a valid UID for local DB and Firestore rules.
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await ensureSignedIn();
  }
}
