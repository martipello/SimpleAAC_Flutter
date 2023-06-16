import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../ui/theme/theme_builder_widget.dart';
import '../view_models/theme_view_model.dart';

extension BuildContextExt on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get scaleFactor => MediaQuery.of(this).textScaleFactor;
  double get topPadding => MediaQueryData.fromWindow(ui.window).padding.top;

  NavigatorState get navigator => Navigator.of(this);

  MaterialLocalizations get materialLocale => MaterialLocalizations.of(this);

  AppLocalizations? get strings => AppLocalizations.of(this);

  dynamic get routeArguments => ModalRoute.of(this)?.settings.arguments;

  ColorScheme get themeColors => Theme.of(this).colorScheme;

  TextTheme get textStyles => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).colorScheme.brightness == Brightness.dark;

  ThemeViewModel get themeViewModel => ThemeBuilderWidget.of(this).themeViewModel;

  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}
