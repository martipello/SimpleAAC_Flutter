import 'package:flutter/material.dart';

import 'base_theme.dart';
import 'simple_aac_text.dart';

enum SimpleAACTheme {
  blue,
  red,
  yellow,
  green,
  pink,
}

AppTheme simpleAACTheme(
  SimpleAACTheme? simpleAACTheme,
) {
  final _baseColors = _getBaseThemeColorForBaseTheme(
    simpleAACTheme,
  );
  return AppTheme(
    baseColors: _baseColors,
    colorScheme: _baseColorScheme(_baseColors),
    logo: _image(),
    baseInputDecorationTheme: _baseInputDecorationTheme(
      _baseColors,
    ),
    baseIconThemeData: _baseIconThemeData(_baseColors),
    baseAppBarTheme: _baseAppBarTheme(_baseColors),
    baseFont: 'Poppins',
  );
}

AppTheme simpleAACBlueTheme(
  SimpleAACTheme simpleAACTheme,
) {
  final _baseColors = _getBaseThemeColorForBaseTheme(
    simpleAACTheme,
  );
  return AppTheme(
    baseColors: _baseColors,
    colorScheme: _baseColorScheme(_baseColors),
    logo: _image(),
    baseInputDecorationTheme: _baseInputDecorationTheme(
      _baseColors,
    ),
    baseIconThemeData: _baseIconThemeData(_baseColors),
    baseAppBarTheme: _baseAppBarTheme(_baseColors),
    baseFont: 'Poppins',
  );
}

BaseThemeColors _getBaseThemeColorForBaseTheme(
  SimpleAACTheme? simpleAACTheme,
) {
  switch (simpleAACTheme) {
    case SimpleAACTheme.blue:
      return _baseThemeColors();
    case SimpleAACTheme.red:
      return _baseThemeColors();
    case SimpleAACTheme.yellow:
      return _baseThemeColors();
    case SimpleAACTheme.green:
      return _baseThemeColors();
    case SimpleAACTheme.pink:
      return _baseThemeColors();
    default:
      return _baseThemeColors();
  }
}

BaseThemeColors _baseThemeColors() {
  const primary = Color(0xFF53c4cf);
  const primaryLight = Color(0xFF5cd7f4);
  const primaryDark = Color(0xFF007691);
  const secondary = Color(0xFFFEAE17);
  const secondaryLight = Color(0xFFffc34c);
  const secondaryDark = Color(0xFFc66300);
  const text = Color(0xFF5e5e5e);
  const textOnForeground = Color(0xFF5e5e5e);
  const textOnPrimary = Color(0xFFFFFFFF);
  const textOnSecondary = Color(0xFFFFFFFF);
  const wordTypeQuicks = Color(0xFFF44336);
  const wordTypeNouns = Color(0xFF2196F3);
  const wordTypeVerbs = Color(0xFFFFEB3B);
  const wordTypeOther = Color(0xFF4CAF50);

  return const BaseThemeColors(
    primary: primary,
    primaryLight: primaryLight,
    primaryDark: primaryDark,
    secondary: secondary,
    onSecondary: secondary,
    secondaryLight: secondaryLight,
    secondaryDark: secondaryDark,
    text: text,
    textOnForeground: textOnForeground,
    textOnPrimary: textOnPrimary,
    textOnSecondary: textOnSecondary,
    chrome: Color(0xFF5c5c5d),
    chromeLight: Color(0xFF727274),
    chromeLighter: Color(0xFFB5B5B5),
    chromeDark: Color(0xFF383839),
    positive: Color(0xFF8AB341),
    error: Color(0xFFFF654B),
    warning: Color(0xFFFFAA3D),
    guide: Color(0xFF007CF2),
    black: Color(0xFF000000),
    white: Color(0xFFFFFFFF),
    foreground: Color(0xFFFAFAFA),
    background: Color(0xFFEEEEEE),
    wordTypeQuicks: wordTypeQuicks,
    wordTypeNouns: wordTypeNouns,
    wordTypeVerbs: wordTypeVerbs,
    wordTypeOther: wordTypeOther,
  );
}

BaseColorScheme _baseColorScheme(BaseThemeColors baseThemeColors) {
  return BaseColorScheme(
    colorScheme: ColorScheme(
      primary: baseThemeColors.primary,
      primaryVariant: baseThemeColors.primaryDark,
      secondary: baseThemeColors.secondary,
      secondaryVariant: baseThemeColors.secondaryDark,
      surface: const Color(0xFFEEEEEE),
      background: const Color(0xFFEEEEEE),
      error: const Color(0xFFFF654B),
      onPrimary: baseThemeColors.textOnPrimary,
      onSecondary: baseThemeColors.textOnForeground,
      onSurface: const Color(0xFF5c5c5d),
      onBackground: const Color(0xFF5c5c5d),
      onError: const Color(0xFFFF654B),
      brightness: Brightness.light,
    ),
  );
}

Image _image() {
  return Image.asset(
    'assets/images/wordskii_icon.png',
    height: 200,
    width: 200,
  );
}

BaseInputDecorationTheme _baseInputDecorationTheme(
  BaseThemeColors baseThemeColors,
) {
  return BaseInputDecorationTheme(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: SimpleAACText.body3Style.copyWith(
        color: const Color(0xFF5e5e5e),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: baseThemeColors.secondary,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: baseThemeColors.secondary,
        ),
      ),
    ),
  );
}

BaseIconThemeData _baseIconThemeData(
  BaseThemeColors baseThemeColors,
) {
  return BaseIconThemeData(
    iconThemeData: IconThemeData(
      color: baseThemeColors.textOnPrimary,
    ),
  );
}

BaseAppBarTheme _baseAppBarTheme(
  BaseThemeColors baseThemeColors,
) {
  return BaseAppBarTheme(
    appBarTheme: AppBarTheme(
      color: baseThemeColors.primary,
      titleTextStyle: SimpleAACText.subtitle1Style.copyWith(
        color: baseThemeColors.textOnPrimary,
      ),
      toolbarTextStyle: SimpleAACText.subtitle1Style.copyWith(
        color: baseThemeColors.textOnPrimary,
      ),
      iconTheme: IconThemeData(
        color: baseThemeColors.textOnPrimary,
      ),
      actionsIconTheme: IconThemeData(
        color: baseThemeColors.textOnPrimary,
      ),
    ),
  );
}
