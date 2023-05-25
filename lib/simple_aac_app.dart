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
import 'ui/word_detail_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const FlexSchemeData _myFlexScheme = FlexSchemeData(
  name: 'Midnight blue',
  description: 'Midnight blue theme, custom definition of all colors',
  light: FlexSchemeColor(
    primary: Color(0xFF00296B),
    primaryContainer: Color(0xFFA0C2ED),
    secondary: Color(0xFFD26900),
    secondaryContainer: Color(0xFFFFD270),
    tertiary: Color(0xFF5C5C95),
    tertiaryContainer: Color(0xFFC8DBF8),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFFB1CFF5),
    primaryContainer: Color(0xFF3873BA),
    secondary: Color(0xFFFFD270),
    secondaryContainer: Color(0xFFD26900),
    tertiary: Color(0xFFC9CBFC),
    tertiaryContainer: Color(0xFF535393),
  ),
);

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
        colors: themeController.usedScheme == FlexScheme.custom
            ? _myFlexScheme.light
            : FlexColor.schemes[themeController.usedScheme]!.light,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        blendLevel: 10,
        appBarElevation: 0.5,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        typography: Typography.material2021(
          platform: defaultTargetPlatform,
        ),
      ),
      // We make an equivalent definition for the dark theme, but using
      // FlexThemeData.dark() and the dark FlexSchemeColors instead.
      // We also change the blend level and app bar elevation
      darkTheme: FlexThemeData.dark(
        useMaterial3: themeController.useMaterial3,
        colors: themeController.usedScheme == FlexScheme.custom
            ? _myFlexScheme.dark
            : FlexColor.schemes[themeController.usedScheme]!.dark,
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
        AppShell.routeName: (context) => AppShell(),
        WordDetailView.routeName: (context) => WordDetailView(),
        ManageWordView.routeName: (context) => ManageWordView(),
        SettingsView.routeName: (context) => SettingsView(),
      },
    );
  }
}
