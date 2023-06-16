import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'dependency_injection_container.dart';
import 'services/navigation_service.dart';
import 'ui/dashboard/app_shell.dart';
import 'ui/manage_word_view.dart';
import 'ui/settings_view.dart';
import 'ui/theme/theme_controller.dart';
import 'ui/theme/theme_view.dart';
import 'ui/word_detail_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class SimpleAACApp extends StatefulWidget {
  const SimpleAACApp({
    Key? key,
    required this.themeController,
  }) : super(key: key);

  final ThemeController themeController;

  @override
  _SimpleAACAppState createState() => _SimpleAACAppState();
}

class _SimpleAACAppState extends State<SimpleAACApp> {
  final _navigationService = getIt.get<NavigationService>();

  ThemeController get themeController => widget.themeController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleAAC',
      navigatorKey: _navigationService.navigatorKey,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      theme: FlexThemeData.light(
        useMaterial3: themeController.useMaterial3,
        colors: FlexColor.schemes[themeController.usedScheme]!.light,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 10,
        appBarElevation: 0.5,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        typography: Typography.material2021(
          platform: defaultTargetPlatform,
        ),
      ),
      darkTheme: FlexThemeData.dark(
        useMaterial3: themeController.useMaterial3,
        colors: FlexColor.schemes[themeController.usedScheme]!.dark,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
        blendLevel: 12,
        appBarElevation: 1,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        typography: Typography.material2021(
          platform: defaultTargetPlatform,
        ),
      ),
      themeMode: themeController.themeMode,
      initialRoute: AppShell.routeName,
      routes: {
        AppShell.routeName: (context) => const AppShell(),
        WordDetailView.routeName: (context) => WordDetailView(),
        ManageWordView.routeName: (context) => ManageWordView(),
        SettingsView.routeName: (context) => SettingsView(),
        ThemeView.routeName: (context) => ThemeView(),
      },
    );
  }
}
