import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../services/auth_service.dart';
import '../shared_widgets/view_constraint.dart';
import '../theme/simple_aac_text.dart';

class SignInView extends StatefulWidget {
  static const String routeName = '/sign-in';

  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _authService = getIt.get<AuthService>();
  final _googleSignIn = GoogleSignIn();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (kIsWeb) {
        await _signInWithGoogleWeb();
      } else {
        await _signInWithGoogleNative();
      }
      if (mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  /// Web: Firebase's popup flow handles everything natively in the browser.
  Future<void> _signInWithGoogleWeb() async {
    final provider = GoogleAuthProvider();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.isAnonymous) {
      try {
        await currentUser.linkWithPopup(provider);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          await FirebaseAuth.instance.signInWithPopup(provider);
        } else {
          rethrow;
        }
      }
    } else {
      await FirebaseAuth.instance.signInWithPopup(provider);
    }
  }

  /// Mobile: use the google_sign_in package to get a credential then hand it
  /// to Firebase Auth, linking to the existing anonymous account if present.
  Future<void> _signInWithGoogleNative() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // User cancelled.
      setState(() => _isLoading = false);
      return;
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.isAnonymous) {
      try {
        await currentUser.linkWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'credential-already-in-use') {
          await FirebaseAuth.instance.signInWithCredential(credential);
        } else {
          rethrow;
        }
      }
    } else {
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAnonymous = _authService.isAnonymous;
    final colors = context.themeColors;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign in',
          style: SimpleAACText.subtitle2Style.copyWith(
            color: colors.onPrimaryContainer,
          ),
        ),
      ),
      body: SafeArea(
        child: ViewConstraint(
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/simple_aac.png',
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              Text(
                'Simple AAC',
                textAlign: TextAlign.center,
                style: SimpleAACText.h3Style.copyWith(
                  color: colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isAnonymous
                    ? 'Sign in with Google to sync your words across\ndevices. Your existing data will be preserved.'
                    : 'Sign in to access your words across devices.',
                textAlign: TextAlign.center,
                style: SimpleAACText.body2Style.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: SimpleAACText.body3Style.copyWith(
                      color: colors.onErrorContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              GoogleSignInButton(
                clientId: '997985384352-02mb3cdet5u3uoljhr4jmj7i9al610sd.apps.googleusercontent.com',
                loadingIndicator: const CircularProgressIndicator.adaptive(),
                isLoading: _isLoading,
                overrideDefaultTapAction: true,
                onTap: _handleGoogleSignIn,
              ),
              const SizedBox(height: 16),
              Text(
                'By signing in you agree to our Terms of Service.',
                textAlign: TextAlign.center,
                style: SimpleAACText.captionStyle.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
