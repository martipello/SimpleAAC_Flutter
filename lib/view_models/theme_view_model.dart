import 'package:rxdart/rxdart.dart';

import '../services/shared_preferences_service.dart';
import '../ui/theme/simple_aac_theme.dart';

class ThemeViewModel {
  ThemeViewModel(
    this.sharedPreferencesService,
  );

  final SharedPreferencesService sharedPreferencesService;

  final currentThemeStream = BehaviorSubject<String>();

  Future<String> get currentTheme => sharedPreferencesService.theme();

  void setTheme(SimpleAACTheme appTheme) {
    sharedPreferencesService.setTheme(theme: appTheme.name);
  }
}
