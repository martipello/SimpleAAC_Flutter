import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dependency_injection_container.dart' as di;
import 'services/auth_service.dart';
import 'services/shared_preferences_service.dart';
import 'api/repositories/vocabulary_repository.dart';
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

        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        if (kDebugMode) {
          await FirebaseCrashlytics.instance
              .setCrashlyticsCollectionEnabled(false);
        }

        await di.init();
        await di.allReady();

        // Ensure we have an anonymous userId before anything else.
        await di.getIt<AuthService>().ensureSignedIn();

        // Load the bundled vocabulary into memory.
        await di.getIt<VocabularyRepository>().loadCoreVocabulary();

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
