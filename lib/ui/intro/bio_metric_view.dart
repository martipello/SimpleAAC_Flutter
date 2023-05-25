import 'package:flutter/material.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../services/shared_preferences_service.dart';
import 'intro_view.dart';

class BioMetricView extends StatefulWidget {
  @override
  _BioMetricViewState createState() => _BioMetricViewState();
}

class _BioMetricViewState extends State<BioMetricView> {
  final _sharedPreferences = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: _sharedPreferences.useBiometrics(),
      builder: (context, snapshot) {
        final isFingerprintEnabled = snapshot.data ?? false;
        return IntroView(
          title: 'Fast Sign In',
          bodyWidget: _buildBodyWidget(context),
          descriptionLabel: _getEnableFingerprintDescription(
            context,
            isFingerprintEnabled: isFingerprintEnabled,
          ),
          actionButtonLabel: isFingerprintEnabled ? 'Disable' : 'Enable',
          actionButtonFillColor: isFingerprintEnabled ? context.themeColors.background : context.themeColors.secondary,
          actionButtonCallback: () {
            _sharedPreferences.setBiometrics(useBiometrics: !isFingerprintEnabled);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.themeColors.primary),
            borderRadius: BorderRadius.circular(360.0),
          ),
          padding: const EdgeInsets.all(8),
          child: FittedBox(
            child: Icon(
              Icons.fingerprint_rounded,
              color: context.themeColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  String _getEnableFingerprintDescription(
    BuildContext context, {
    bool isFingerprintEnabled = false,
  }) {
    return isFingerprintEnabled
        ? 'Fast sign in enabled'
        : context.strings?.use_biometrics_message ??
            'Would you like to enable fingerprint / facial recognition for fast sign in?';
  }
}
