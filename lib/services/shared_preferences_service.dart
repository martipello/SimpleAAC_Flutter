import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class SharedPreferencesService {
  SharedPreferencesService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  final relatedWordsEnabled = BehaviorSubject<bool?>();
  final currentLanguageId = BehaviorSubject<String?>();

  bool isFirstTime() {
    return sharedPreferences.getBool(Constants.FIRST_TIME) ?? true;
  }

  bool hasRelatedWordsEnabled() {
    return sharedPreferences.getBool(Constants.RELATED_WORDS) ?? true;
  }

  String email() {
    return sharedPreferences.getString(Constants.EMAIL_KEY) ?? '';
  }

  String name() {
    return sharedPreferences.getString(Constants.USER_FIRST_NAME) ?? '';
  }

  String lastName() {
    return sharedPreferences.getString(Constants.USER_LAST_NAME) ?? '';
  }

  String themeName() {
    return sharedPreferences.getString(Constants.THEME_NAME) ?? 'red';
  }

  String languageId() {
    return sharedPreferences.getString(Constants.LANGUAGE_ID) ?? '';
  }

  bool useBiometrics() {
    if (sharedPreferences.containsKey(Constants.BIOMETRIC_KEY)) {
      if (sharedPreferences.getBool(Constants.BIOMETRIC_KEY) == true) {
        return true;
      }
    }
    return false;
  }

  void setFirstTime({required bool isFirstTime}) {
    sharedPreferences.setBool(Constants.FIRST_TIME, isFirstTime);
  }

  //ignore: avoid_positional_boolean_parameters
  void setRelatedWordsEnabled(bool hasRelatedWordsEnabled) {
    sharedPreferences.setBool(Constants.RELATED_WORDS, hasRelatedWordsEnabled);
    relatedWordsEnabled.add(hasRelatedWordsEnabled);
  }

  void setBiometrics({required bool useBiometrics}) {
    sharedPreferences.setBool(Constants.BIOMETRIC_KEY, useBiometrics);
  }

  void setEmail(String email) {
    sharedPreferences.setString(Constants.EMAIL_KEY, email);
  }

  void setUserName(String userName) {
    sharedPreferences.setString(Constants.USER_FIRST_NAME, userName);
  }

  void setUserLastName(String userLastName) {
    sharedPreferences.setString(Constants.USER_LAST_NAME, userLastName);
  }

  void setThemeName(String themeName) {
    sharedPreferences.setString(Constants.THEME_NAME, themeName);
  }

  void setLanguageId(String languageId) {
    currentLanguageId.add(languageId);
    sharedPreferences.setString(Constants.LANGUAGE_ID, languageId);
  }

  void dispose() {
    relatedWordsEnabled.close();
    currentLanguageId.close();
  }

  static Future<bool> get firstTime => SharedPreferences.getInstance().then(
        (sharedPreferences) => sharedPreferences.getBool(Constants.FIRST_TIME) ?? true,
      );
}
