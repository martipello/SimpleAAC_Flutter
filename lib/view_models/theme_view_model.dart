import 'package:flex_color_scheme/flex_color_scheme.dart';

import '../services/theme_service.dart';
import '../ui/theme/theme_controller.dart';

class ThemeViewModel {
  ThemeViewModel(
    this.themeService,
    this.themeController,
  );

  final ThemeService themeService;
  final ThemeController themeController;

  Future<void> init() async {
    await themeController.loadAll();
    themeController.setUsedScheme(FlexScheme.mandyRed);
  }
}
