import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get scaleFactor => MediaQuery.of(this).textScaleFactor;

  NavigatorState get navigator => Navigator.of(this);

  MaterialLocalizations get materialLocale => MaterialLocalizations.of(this);

  AppLocalizations? get strings => AppLocalizations.of(this);

  dynamic get routeArguments => ModalRoute.of(this)?.settings.arguments;

  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild?.context?.widget is! EditableText);
  }
}
