import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'api/hive.dart';
import 'dependency_injection_container.dart' as di;
import 'dependency_injection_container.dart';
import 'api/services/shared_preferences_service.dart';
import 'simple_aac_app.dart';
import 'ui/theme/theme_builder_widget.dart';
import 'view_models/theme_view_model.dart';

// ignore: avoid_classes_with_only_static_members
class SimpleAACAppWrapper extends StatefulWidget {
  const SimpleAACAppWrapper({
    required this.themeViewModel,
    super.key,
  });

  final ThemeViewModel themeViewModel;

  static void init() async {
    await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await initializeFirebase();
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        if (kDebugMode) {
          await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
        }

        final appDocumentDir = await getApplicationDocumentsDirectory();
        await initHive(appDocumentDir);
        await di.init();
        await di.allReady();

        final isFirstTime = await SharedPreferencesService.firstTime;
        if(isFirstTime) {
          await populateInitialData();
        }

        final themeViewModel = di.getIt.get<ThemeViewModel>();
        await themeViewModel.init();

        runApp(
          SimpleAACAppWrapper(
            themeViewModel: themeViewModel,
          ),
        );
      },
      (final error, final stack) => FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        reason: 'Zoned Error',
      ),
    );
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  State<SimpleAACAppWrapper> createState() => _SimpleAACAppWrapperState();
}

class _SimpleAACAppWrapperState extends State<SimpleAACAppWrapper> {
  //ties its lifecyle to the app
  final sharedPreferences = getIt.get<SharedPreferencesService>();

  @override
  void dispose() {
    super.dispose();
    sharedPreferences.dispose();
  }
  @override
  Widget build(final BuildContext context) {
    return ThemeBuilderWidget(
      themeViewModel: widget.themeViewModel,
      themeBuilder: (final themeController) {
        return SimpleAACApp(
          themeController: themeController,
        );
      },
    );
  }
}
