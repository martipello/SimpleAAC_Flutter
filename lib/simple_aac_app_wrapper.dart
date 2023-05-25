import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_aac/ui/theme/theme_builder_widget.dart';

import 'api/models/word.dart';
import 'api/models/word_sub_type.dart';
import 'api/models/word_type.dart';
import 'dependency_injection_container.dart' as di;
import 'api/models/theme_service_hive_adapters.dart';
import 'simple_aac_app.dart';
import 'view_models/theme_view_model.dart';

// ignore: avoid_classes_with_only_static_members
class SimpleAACAppWrapper {
  static void init() async {
    runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await initializeFirebase();
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        if (kDebugMode) {
          await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
        }
        await di.init();
        await di.allReady();
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
        Hive
          ..registerAdapter<Word>(WordAdapter())
          ..registerAdapter<WordSubType>(WordSubTypeAdapter())
          ..registerAdapter<WordType>(WordTypeAdapter())
          ..registerAdapter(ThemeModeAdapter())
          ..registerAdapter(ColorAdapter())
          ..registerAdapter(FlexSchemeAdapter())
          ..registerAdapter(FlexSurfaceModeAdapter())
          ..registerAdapter(FlexInputBorderTypeAdapter())
          ..registerAdapter(FlexTabBarStyleAdapter())
          ..registerAdapter(FlexAppBarStyleAdapter())
          ..registerAdapter(FlexSystemNavBarStyleAdapter())
          ..registerAdapter(FlexSchemeColorAdapter())
          ..registerAdapter(NavigationDestinationLabelBehaviorAdapter())
          ..registerAdapter(NavigationRailLabelTypeAdapter())
          ..registerAdapter(FlexSliderIndicatorTypeAdapter())
          ..registerAdapter(ShowValueIndicatorAdapter())
          ..registerAdapter(TabBarIndicatorSizeAdapter())
          ..registerAdapter(AdaptiveThemeAdapter());

        final themeViewModel = di.getIt.get<ThemeViewModel>();
        await themeViewModel.init();
        runApp(
          _buildThemeWrapper(),
        );
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, reason: 'Zoned Error'),
    );
  }

  static Widget _buildThemeWrapper() {
    return ThemeBuilderWidget(
      themeBuilder: (themeController) {
        return SimpleAACApp(
          themeController: themeController,
        );
      },
    );
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
}
