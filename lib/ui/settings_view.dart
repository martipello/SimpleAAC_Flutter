import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../api/models/language.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../services/shared_preferences_service.dart';
import '../view_models/language_view_model.dart';
import 'language_view.dart';
import 'theme/simple_aac_text.dart';
import 'theme/theme_view.dart';

class SettingsView extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _sharedPreferenceService = getIt.get<SharedPreferencesService>();
  final _languageViewModel = getIt.get<LanguageViewModel>();

  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierBuilder(
      notifier: _sharedPreferenceService,
      builder: (final context, final _, final __) {
        final _hasRelatedWordsEnabled = _sharedPreferenceService.hasRelatedWordsEnabled;
        return Scaffold(
          appBar: _settingsAppBar(),
          body: FutureBuilder<Language>(
            future: _languageViewModel.getCurrentLanguage(),
            builder: (final context, final snapshot) {
              final _currentLanguage = snapshot.data;
              return _buildSettingsList(
                _currentLanguage,
                _hasRelatedWordsEnabled,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSettingsList(
    final Language? currentLanguage,
    final bool _hasRelatedWordsEnabled,
  ) {
    return SettingsList(
      sections: [
        _buildLanguageSettingsSection(
          currentLanguage,
        ),
        _buildPredictionsSettingsSection(
          _hasRelatedWordsEnabled,
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
        style: SimpleAACText.body1Style,
      ),
      tiles: [
        SettingsTile.switchTile(
          initialValue: isDark,
          onToggle: (final _) {
            if (isDark) {
              context.themeViewModel.setThemeMode(ThemeMode.light);
            } else {
              context.themeViewModel.setThemeMode(ThemeMode.dark);
            }
          },
          title: Text(
            'Current theme mode is ${isDark ? 'Dark' : 'Light'}',
            style: SimpleAACText.body1Style,
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
        style: SimpleAACText.body1Style,
      ),
      tiles: [
        SettingsTile.navigation(
          title: Text(
            'Current theme $currentThemeName',
            style: SimpleAACText.body1Style,
          ),
          onPressed: (final _) {
            Navigator.of(context).pushNamed(ThemeView.routeName);
          },
        ),
      ],
    );
  }

  SettingsSection _buildLanguageSettingsSection(
    final Language? currentLanguage,
  ) {
    return SettingsSection(
      title: const Text(
        'Language',
        style: SimpleAACText.body1Style,
      ),
      tiles: [
        SettingsTile(
          title: Text(
            'Current Language is ${currentLanguage?.displayName ?? 'Default'}',
            style: SimpleAACText.body1Style,
          ),
          onPressed: (final _) {
            Navigator.of(context).pushNamed(
              LanguageView.routeName,
            );
          },
        ),
      ],
    );
  }

  SettingsSection _buildPredictionsSettingsSection(
    final bool _hasRelatedWordsEnabled,
  ) {
    return SettingsSection(
      title: const Text(
        'Predictions',
        style: SimpleAACText.body1Style,
      ),
      tiles: [
        SettingsTile.switchTile(
          initialValue: _hasRelatedWordsEnabled,
          onToggle: _sharedPreferenceService.setRelatedWordsEnabled,
          title: const Text(
            'Show related words when selecting a word',
            style: SimpleAACText.body1Style,
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
