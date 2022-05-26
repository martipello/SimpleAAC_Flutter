import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'dependency_injection_container.dart' as di;
import 'extensions/enum_extension.dart';
import 'simple_aac_app.dart';
import 'ui/theme/base_theme.dart';
import 'ui/theme/simple_aac_theme.dart';
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
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
        // Hive
        //   ..registerAdapter<Timesheet>(TimesheetAdapter())
        //   ..registerAdapter<FileEntry>(FileEntryAdapter())
        //   ..registerAdapter<TimesheetStatus>(TimesheetStatusAdapter())
        //   ..registerAdapter<BookingStatus>(BookingStatusAdapter())
        //   ..registerAdapter<Attendee>(AttendeeAdapter())
        //   ..registerAdapter<HiveFileModel>(HiveFileModelAdapter());

        runApp(
          _buildTheme(),
        );
      },
      (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack, reason: 'Zoned Error'),
    );
  }

  static Widget _buildTheme() {
    return ThemeBuilder();
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
}

class ThemeBuilder extends StatelessWidget {
  ThemeBuilder({
    Key? key,
  }) : super(key: key);

  final themeViewModel = di.getIt.get<ThemeViewModel>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: themeViewModel.currentTheme,
      builder: (context, initialThemeSnapshot) {
        if (initialThemeSnapshot.hasData) {
          return StreamBuilder<String>(
            initialData: initialThemeSnapshot.data,
            stream: themeViewModel.currentThemeStream,
            builder: (context, snapshot) {
              final _simpleAACTheme = enumFromString(
                snapshot.data ?? '',
                SimpleAACTheme.values,
              );
              return _buildBaseTheme(_simpleAACTheme);
            },
          );
        } else {
          return _buildBaseTheme(null);
        }
      },
    );
  }

  Widget _buildBaseTheme(
    SimpleAACTheme? _simpleAACTheme,
  ) {
    return BaseTheme(
      appTheme: simpleAACTheme(_simpleAACTheme),
      child: Builder(
        builder: (context) {
          return SimpleAACApp(
            theme: BaseTheme.of(context),
          );
        },
      ),
    );
  }
}
