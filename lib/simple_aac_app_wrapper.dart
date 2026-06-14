import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'dependency_injection_container.dart' as di;
import 'services/auth_service.dart';
import 'services/language_service.dart';
import 'services/shared_preferences_service.dart';
import 'services/sync_mediator.dart';
import 'simple_aac_app.dart';
import 'ui/theme/theme_builder_widget.dart';
import 'view_models/theme_view_model.dart';

class SimpleAACAppWrapper extends StatefulWidget {
  const SimpleAACAppWrapper({
    super.key,
    required this.themeViewModel,
  });

  final ThemeViewModel themeViewModel;

  static void init() {
    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        FirebaseUIAuth.configureProviders([
          GoogleProvider(clientId: '', iOSPreferPlist: true),
        ]);

        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        if (kDebugMode) {
          await FirebaseCrashlytics.instance
              .setCrashlyticsCollectionEnabled(false);
        }

        await di.init();
        await di.allReady();

        // Load language metadata (id, displayName, preview words) from bundled asset.
        await di.getIt<LanguageService>().init();

        // Start sync: ensures anonymous auth, seeds core vocab from Firebase,
        // and wires up real-time user data listeners.
        await di.getIt<SyncMediator>().start();

        // Refresh token whenever Firebase issues a new one (e.g. after sign-in).
        di.getIt<AuthService>().idTokenChanges.listen((user) async {
          if (user != null) await user.getIdToken();
        });

        // Populate initial data only on first launch.
        final isFirstTime = await SharedPreferencesService.firstTime;
        if (isFirstTime) {
          di.getIt<SharedPreferencesService>().setFirstTime(isFirstTime: false);
        }

        final themeViewModel = di.getIt<ThemeViewModel>();
        await themeViewModel.init();

        runApp(SimpleAACAppWrapper(themeViewModel: themeViewModel));
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        reason: 'Zoned Error',
      ),
    );
  }

  @override
  State<SimpleAACAppWrapper> createState() => _SimpleAACAppWrapperState();
}

class _SimpleAACAppWrapperState extends State<SimpleAACAppWrapper> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilderWidget(
      themeViewModel: widget.themeViewModel,
      themeBuilder: (themeController) =>
          SimpleAACApp(themeController: themeController),
    );
  }
}
