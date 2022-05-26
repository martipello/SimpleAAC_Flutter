import 'package:flutter/material.dart';

class BaseTheme extends InheritedWidget {
  const BaseTheme({
    Key? key,
    required this.appTheme,
    required Widget child,
  }) : super(key: key, child: child);

  final AppTheme appTheme;

  BaseThemeColors get colors => appTheme.baseColors;

  BaseColorScheme get colorScheme => appTheme.colorScheme;

  IconThemeData get iconThemeData => appTheme.baseIconThemeData.iconThemeData;

  InputDecorationTheme get inputDecorationTheme => appTheme.baseInputDecorationTheme.inputDecorationTheme;

  AppBarTheme get appBarTheme => appTheme.baseAppBarTheme.appBarTheme;

  Widget get logo => appTheme.logo;

  String? get font => appTheme.baseFont;

  static BaseTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BaseTheme>()!;
  }

  @override
  bool updateShouldNotify(BaseTheme oldWidget) {
    return true;
  }
}

BaseThemeColors colors(BuildContext context) {
  return BaseTheme.of(context).colors;
}

class AppTheme {
  AppTheme({
    this.colorScheme = const BaseColorScheme(),
    this.baseAppBarTheme = const BaseAppBarTheme(),
    this.baseInputDecorationTheme = const BaseInputDecorationTheme(),
    this.baseColors = const BaseThemeColors(),
    this.baseIconThemeData = const BaseIconThemeData(),
    this.baseFont,
    required this.logo,
  });

  final BaseThemeColors baseColors;

  final BaseColorScheme colorScheme;

  final BaseInputDecorationTheme baseInputDecorationTheme;

  final BaseIconThemeData baseIconThemeData;

  final BaseAppBarTheme baseAppBarTheme;

  final String? baseFont;

  final Widget logo;
}

class BaseAppBarTheme {
  const BaseAppBarTheme({
    this.appBarTheme = const AppBarTheme(
      color: Color(0xFF006CC7),
      iconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xFFFFFFFF),
      ),
      titleTextStyle: TextStyle(fontSize: 18, color: Colors.white),
      toolbarTextStyle: TextStyle(fontSize: 18, color: Colors.white),
    ),
  });

  final AppBarTheme appBarTheme;
}

class BaseInputDecorationTheme {
  const BaseInputDecorationTheme({
    this.inputDecorationTheme = const InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF006CC7)),
      ),
    ),
  });

  final InputDecorationTheme inputDecorationTheme;
}

class BaseIconThemeData {
  const BaseIconThemeData({
    this.iconThemeData = const IconThemeData(
      color: Color(0xFF2e2e2e),
    ),
  });

  final IconThemeData iconThemeData;
}

class BaseColorScheme {
  const BaseColorScheme({
    this.colorScheme = const ColorScheme(
      primary: Color(0xFF006CC7),
      primaryVariant: Color(0xFF5b9afb),
      secondary: Color(0xFF003399),
      secondaryVariant: Color(0xFF006CC7),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      error: Color(0xFFBA2F00),
      onPrimary: Color(0xFF006CC7),
      onSecondary: Color(0xFF003399),
      onSurface: Color(0xFF006CC7),
      onBackground: Color(0xFF006CC7),
      onError: Color(0xFFBA2F00),
      brightness: Brightness.light,
    ),
  });

  final ColorScheme colorScheme;
}

class BaseThemeColors {
  const BaseThemeColors({
    this.primary = const Color(0xFF006CC7),
    this.primaryLight = const Color(0xFF5b9afb),
    this.primaryDark = const Color(0xFF004296),
    this.secondary = const Color(0xFF003399),
    this.onSecondary = const Color(0xFF003399),
    this.secondaryLight = const Color(0xFF505ccb),
    this.secondaryDark = const Color(0xFF00106a),
    this.foreground = const Color(0xFFFFFFFF),
    this.text = const Color(0xFF2e2e2e),
    this.textOnPrimary = const Color(0xFFFFFFFF),
    this.textOnSecondary = const Color(0xFFFFFFFF),
    this.textOnForeground = const Color(0xFF2e2e2e),
    this.chrome = const Color(0xFFCCCCCC),
    this.chromeLight = const Color(0xFFE1E1E1),
    this.chromeLighter = const Color(0xFFF2F2F4),
    this.chromeDark = const Color(0xFF333333),
    this.link = const Color(0xFF3965FF),
    this.positive = const Color(0xFF26A626),
    this.error = const Color(0xFFBA2F00),
    this.warning = const Color(0xFFFD9726),
    this.guide = const Color(0xFF80CDD8),
    this.black = const Color(0xFF000000),
    this.white = const Color(0xFFFFFFFF),
    this.background = const Color(0xFFEEEEEE),
    this.wordTypeQuicks = const Color(0xFFF44336),
    this.wordTypeNouns = const Color(0xFF2196F3),
    this.wordTypeVerbs = const Color(0xFFFFEB3B),
    this.wordTypeOther = const Color(0xFF4CAF50),
  });

  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryLight;
  final Color secondaryDark;
  final Color foreground;

  final Color chrome;
  final Color chromeLight;
  final Color chromeLighter;
  final Color chromeDark;
  final Color text;
  final Color textOnForeground;
  final Color textOnPrimary;
  final Color textOnSecondary;

  final Color link;

  final Color positive;
  final Color error;
  final Color warning;
  final Color guide;

  final Color black;
  final Color white;
  final Color background;

  final Color wordTypeQuicks;
  final Color wordTypeNouns;
  final Color wordTypeVerbs;
  final Color wordTypeOther;
}
