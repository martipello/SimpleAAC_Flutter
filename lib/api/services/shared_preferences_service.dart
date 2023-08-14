import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../models/extensions/word_base_extension.dart';

const defaultLanguageId = '${kLanguageIdPrefix}1';

class SharedPreferencesService extends ChangeNotifier {
  SharedPreferencesService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  bool get isFirstTime => sharedPreferences.getBool(Constants.FIRST_TIME) ?? true;

  bool get hasRelatedWordsEnabled => sharedPreferences.getBool(Constants.RELATED_WORDS) ?? true;

  String get email => sharedPreferences.getString(Constants.EMAIL_KEY) ?? '';

  String get name => sharedPreferences.getString(Constants.USER_FIRST_NAME) ?? '';

  String get lastName => sharedPreferences.getString(Constants.USER_LAST_NAME) ?? '';

  String get themeName => sharedPreferences.getString(Constants.THEME_NAME) ?? 'red';

  String get currentLanguageId => sharedPreferences.getString(Constants.LANGUAGE_ID) ?? defaultLanguageId;

  bool get useBiometrics => sharedPreferences.getBool(Constants.BIOMETRIC_KEY) == true;

  void setFirstTime({required final bool isFirstTime}) {
    sharedPreferences.setBool(Constants.FIRST_TIME, isFirstTime);
    notifyListeners();
  }

  //ignore: avoid_positional_boolean_parameters
  void setRelatedWordsEnabled(final bool hasRelatedWordsEnabled) {
    sharedPreferences.setBool(Constants.RELATED_WORDS, hasRelatedWordsEnabled);
    notifyListeners();
  }

  void setBiometrics({required final bool useBiometrics}) {
    sharedPreferences.setBool(Constants.BIOMETRIC_KEY, useBiometrics);
    notifyListeners();
  }

  void setEmail(final String email) {
    sharedPreferences.setString(Constants.EMAIL_KEY, email);
    notifyListeners();
  }

  void setUserName(final String userName) {
    sharedPreferences.setString(Constants.USER_FIRST_NAME, userName);
    notifyListeners();
  }

  void setUserLastName(final String userLastName) {
    sharedPreferences.setString(Constants.USER_LAST_NAME, userLastName);
    notifyListeners();
  }

  void setThemeName(final String themeName) {
    sharedPreferences.setString(Constants.THEME_NAME, themeName);
    notifyListeners();
  }

  void setLanguageId(final String languageId) {
    sharedPreferences.setString(Constants.LANGUAGE_ID, languageId);
    notifyListeners();
  }

  static Future<bool> get firstTime => SharedPreferences.getInstance().then(
        (final sharedPreferences) => sharedPreferences.getBool(Constants.FIRST_TIME) ?? true,
      );
}
