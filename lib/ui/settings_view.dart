import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../services/shared_preferences_service.dart';
import 'theme/simple_aac_text.dart';
import 'theme/theme_view.dart';

class SettingsView extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _sharedPreferenceService = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: _sharedPreferenceService.relatedWordsEnabled,
      builder: (context, snapshot) {
        final _hasPredictionsEnabled = snapshot.data == true;
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
    final isDark = context.isDark;

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
              context.themeViewModel.setThemeMode(ThemeMode.light);
            } else {
              context.themeViewModel.setThemeMode(ThemeMode.dark);
            }
          },
          title: Text(
            'Current theme mode is ${isDark ? 'Dark' : 'Light'}',
            style: SimpleAACText.body4Style,
          ),
        ),
      ],
    );
  }

  SettingsSection _buildThemeSettingsSection() {
    final currentThemeName = context.themeViewModel.themeName;
    return SettingsSection(
      title: const Text(
        'Theme',
        style: SimpleAACText.body4Style,
      ),
      tiles: [
        SettingsTile.navigation(
          title: Text(
            'Current theme $currentThemeName',
            style: SimpleAACText.body4Style,
          ),
          onPressed: (_){
            Navigator.of(context).pushNamed(ThemeView.routeName);
          },
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
          onToggle: _sharedPreferenceService.setRelatedWordsEnabled,
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
