import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'dependency_injection_container.dart';
import 'services/navigation_service.dart';
import 'ui/create_word_view.dart';
import 'ui/dashboard/app_shell.dart';
import 'ui/settings_view.dart';
import 'ui/theme/base_theme.dart';
import 'ui/theme/simple_aac_text.dart';
import 'ui/word_detail_view.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class SimpleAACApp extends StatefulWidget {
  const SimpleAACApp({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final BaseTheme theme;

  @override
  _SimpleAACAppState createState() => _SimpleAACAppState();
}

class _SimpleAACAppState extends State<SimpleAACApp> {
  final _navigationService = getIt.get<NavigationService>();

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
      theme: ThemeData(
        primaryColor: widget.theme.colors.primary,
        iconTheme: widget.theme.iconThemeData,
        colorScheme: widget.theme.colorScheme.colorScheme,
        inputDecorationTheme: widget.theme.inputDecorationTheme,
        brightness: Brightness.light,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colors(context).secondary,
          selectionColor: colors(context).secondary,
          selectionHandleColor: colors(context).secondary,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: SimpleAACText.body3Style,
          unselectedLabelStyle: SimpleAACText.body4Style,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: colors(context).secondary),
          ),
        ),
        fontFamily: widget.theme.font,
        appBarTheme: widget.theme.appBarTheme,
      ),
      initialRoute: AppShell.routeName,
      routes: {
        AppShell.routeName: (context) => AppShell(),
        WordDetailView.routeName: (context) => WordDetailView(),
        CreateWordView.routeName: (context) => CreateWordView(),
        SettingsView.routeName: (context) => SettingsView(),
      },
    );
  }
}
