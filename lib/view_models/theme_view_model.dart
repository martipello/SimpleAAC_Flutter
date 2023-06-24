import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../services/shared_preferences_service.dart';
import '../ui/theme/theme_controller.dart';

class ThemeViewModel {
  ThemeViewModel(
    this.themeController,
    this.sharedPreferencesService,
  );

  final ThemeController themeController;
  final SharedPreferencesService sharedPreferencesService;

  Future<void> init({bool doSetInitialTheme = true}) async {
    await themeController.loadAll();
    if(doSetInitialTheme) {
      await setInitialTheme();
    }
  }

  Future<void> setInitialTheme() async {
    final themeName = sharedPreferencesService.themeName;
    final theme = SimpleAACTheme.getTheme(themeName);
    setTheme(theme);
  }

  void setTheme(SimpleAACTheme simpleAACTheme) {
    sharedPreferencesService.setThemeName(simpleAACTheme.name);
    themeController.setUsedScheme(
      simpleAACTheme.color,
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    themeController.setThemeMode(
      themeMode,
    );
  }

  String? get themeName => FlexColor.schemes[themeController.usedScheme]?.name;

  ThemeMode get themeMode => themeController.themeMode;

  void dispose(){
    themeController.dispose();
  }
}

enum SimpleAACTheme {
  red(color: FlexScheme.redM3),
  blue(color: FlexScheme.blueM3),
  yellow(color: FlexScheme.yellowM3),
  green(color: FlexScheme.limeM3),
  pink(color: FlexScheme.pinkM3),
  purple(color: FlexScheme.purpleM3);

  const SimpleAACTheme({
    required this.color,
  });

  final FlexScheme color;

  static SimpleAACTheme getTheme(String themeName) {
    return SimpleAACTheme.values.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => SimpleAACTheme.red,
    );
  }
}
