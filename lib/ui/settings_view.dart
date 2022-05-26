import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../dependency_injection_container.dart';
import '../services/shared_preferences_service.dart';
import 'theme/base_theme.dart';
import 'theme/simple_aac_text.dart';

class SettingsView extends StatefulWidget {
  static const String routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _sharedPreferenceService = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      builder: (context, initialDataSnapshot) {
        return StreamBuilder<bool?>(
          initialData: initialDataSnapshot.data,
          stream: _sharedPreferenceService.hasPredictionsEnabledStream,
          builder: (context, snapshot) {
            final _hasPredictionsEnabled = snapshot.data ?? initialDataSnapshot.data ?? true;
            return Scaffold(
              appBar: _settingsAppBar(context),
              body: _buildSettingsList(_hasPredictionsEnabled),
            );
          },
        );
      },
    );
  }

  Widget _buildSettingsList(bool _hasPredictionsEnabled) {
    return SettingsList(
      sections: [
        _buildSettingsSectionPredictions(_hasPredictionsEnabled),
      ],
    );
  }

  SettingsSection _buildSettingsSectionPredictions(
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

  PreferredSizeWidget _settingsAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: colors(context).textOnForeground,
        ),
      ),
      title: Text(
        'Settings',
        style: SimpleAACText.subtitle2Style.copyWith(
          color: colors(context).textOnForeground,
        ),
      ),
    );
  }
}
