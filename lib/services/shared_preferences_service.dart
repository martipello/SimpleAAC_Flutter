import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dependency_injection_container.dart';
import '../utils/constants.dart';

class SharedPreferencesService {
  final _sharedPreferences = getIt.getAsync<SharedPreferences>();

  final hasPredictionsEnabledStream = BehaviorSubject<bool?>();

  Future<SharedPreferences> sharedPreferences() {
    return _sharedPreferences;
  }

  Future<bool> isFirstTime() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getBool(Constants.FIRST_TIME) ?? true;
  }

  Future<bool> hasPredictionsEnabled() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getBool(Constants.PREDICTIONS) ?? true;
  }

  Future<String> email() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(Constants.EMAIL_KEY) ?? '';
  }

  Future<String> name() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(Constants.USER_FIRST_NAME) ?? '';
  }

  Future<String> theme() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(Constants.THEME) ?? '';
  }

  Future<String> lastName() async {
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(Constants.USER_LAST_NAME) ?? '';
  }

  Future<bool> useBiometrics() async {
    final sharedPreferences = await _sharedPreferences;
    if (sharedPreferences.containsKey(Constants.BIOMETRIC_KEY)) {
      if (sharedPreferences.getBool(Constants.BIOMETRIC_KEY) == true) {
        return true;
      }
    }
    return false;
  }

  Future<void> setFirstTime({required bool isFirstTime}) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setBool(Constants.FIRST_TIME, isFirstTime);
  }

  Future<void> setTheme({required String theme}) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(Constants.THEME, theme);
  }

  //ignore: avoid_positional_boolean_parameters
  Future<void> setPredictionsEnabled(bool hasPredictionsEnabled) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setBool(Constants.PREDICTIONS, hasPredictionsEnabled);
    hasPredictionsEnabledStream.add(hasPredictionsEnabled);
  }

  Future<void> setBiometrics({required bool useBiometrics}) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setBool(Constants.BIOMETRIC_KEY, useBiometrics);
  }

  Future<void> setEmail(String email) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(Constants.EMAIL_KEY, email);
  }

  Future<void> setUserName(String userName) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(Constants.USER_FIRST_NAME, userName);
  }

  Future<void> setUserLastName(String userLastName) async {
    final sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString(Constants.USER_LAST_NAME, userLastName);
  }

  void dispose() {
    hasPredictionsEnabledStream.close();
  }
}
