// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Simple AAC';

  @override
  String get use_biometrics_message =>
      'Would you like to enable fingerprint / facial recognition for fast sign in?';

  @override
  String get welcome => 'Welcome';
}
