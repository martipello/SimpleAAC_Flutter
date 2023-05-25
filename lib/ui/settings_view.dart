import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../services/shared_preferences_service.dart';
import '../view_models/theme_view_model.dart';
import 'theme/simple_aac_text.dart';

class SettingsView extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _sharedPreferenceService = getIt.get<SharedPreferencesService>();
  final _themeViewModel = getIt.get<ThemeViewModel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: _sharedPreferenceService.hasPredictionsEnabledStream,
      builder: (context, snapshot) {
        final _hasPredictionsEnabled = snapshot.data == true;
        final themeMode = _themeViewModel.themeController.themeMode;
        return Scaffold(
          appBar: _settingsAppBar(),
          body: _buildSettingsList(
            _hasPredictionsEnabled,
          ),
        );
      },
    );
  }

  Widget _buildSettingsList(
    bool _hasPredictionsEnabled,
  ) {
    return SettingsList(
      sections: [
        _buildPredictionsSettingsSection(
          _hasPredictionsEnabled,
        ),
        _buildThemeModeSettingsSection(),
        _buildThemeSettingsSection(),
      ],
    );
  }

  SettingsSection _buildThemeModeSettingsSection() {
    final themeMode = _themeViewModel.themeController.themeMode;
    final isDark = themeMode == ThemeMode.dark;
    return SettingsSection(
      title: const Text(
        'Dark Mode',
        style: SimpleAACText.body4Style,
      ),
      tiles: [
        SettingsTile.switchTile(
          initialValue: isDark,
          onToggle: (_){
            if(isDark) {
              _themeViewModel.themeController.setThemeMode(ThemeMode.light);
            } else {
              _themeViewModel.themeController.setThemeMode(ThemeMode.dark);
            }
          },
          title: Text(
            'Current theme mode $themeMode',
            style: SimpleAACText.body4Style,
          ),
        ),
      ],
    );
  }

  SettingsSection _buildThemeSettingsSection() {
    final name = FlexColor.schemes[_themeViewModel.themeController.usedScheme]?.name;
    return SettingsSection(
      title: const Text(
        'Theme',
        style: SimpleAACText.body4Style,
      ),
      tiles: [
        SettingsTile.switchTile(
          initialValue: true,
          onToggle: _sharedPreferenceService.setPredictionsEnabled,
          title: Text(
            'Current theme $name',
            style: SimpleAACText.body4Style,
          ),
        ),
      ],
    );
  }

  SettingsSection _buildPredictionsSettingsSection(
    bool _hasPredictionsEnabled,
  ) {
    return SettingsSection(
      title: const Text(
        'Predictions',
        style: SimpleAACText.body4Style,
      ),
      tiles: [
        SettingsTile.switchTile(
          initialValue: _hasPredictionsEnabled,
          onToggle: _sharedPreferenceService.setPredictionsEnabled,
          title: const Text(
            'Show predictions when selecting cards',
            style: SimpleAACText.body4Style,
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _settingsAppBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        'Settings',
        style: SimpleAACText.subtitle2Style.copyWith(
          color: context.themeColors.onPrimaryContainer,
        ),
      ),
    );
  }
}
