import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

const defaultLanguageId = 'en';

class SharedPreferencesService extends ChangeNotifier {
  SharedPreferencesService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  /// Exposed for ThemeService JSON storage.
  SharedPreferences get preferences => sharedPreferences;

  bool get isFirstTime => sharedPreferences.getBool(Constants.FIRST_TIME) ?? true;

  bool get hasRelatedWordsEnabled => sharedPreferences.getBool(Constants.RELATED_WORDS) ?? true;

  String get email => sharedPreferences.getString(Constants.EMAIL_KEY) ?? '';

  String get name => sharedPreferences.getString(Constants.USER_FIRST_NAME) ?? '';

  String get lastName => sharedPreferences.getString(Constants.USER_LAST_NAME) ?? '';

  String get themeName => sharedPreferences.getString(Constants.THEME_NAME) ?? 'red';

  ThemeMode get themeMode {
    final stored = sharedPreferences.getString(Constants.THEME_MODE);
    return ThemeMode.values.firstWhere(
      (m) => m.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  String get currentLanguageId => sharedPreferences.getString(Constants.LANGUAGE_ID) ?? defaultLanguageId;

  bool get useBiometrics => sharedPreferences.getBool(Constants.BIOMETRIC_KEY) == true;

  double get ttsPitch => sharedPreferences.getDouble(Constants.TTS_PITCH) ?? 1.05;

  double get ttsSpeechRate => sharedPreferences.getDouble(Constants.TTS_SPEECH_RATE) ?? 0.44;

  String? get ttsVoiceName => sharedPreferences.getString(Constants.TTS_VOICE_NAME);

  String? get ttsVoiceLocale => sharedPreferences.getString(Constants.TTS_VOICE_LOCALE);

  String get ttsOpenAiVoice => sharedPreferences.getString(Constants.TTS_OPENAI_VOICE) ?? 'nova';

  bool get highlightWordsEnabled => sharedPreferences.getBool(Constants.TTS_HIGHLIGHT_WORDS) ?? true;

  bool get useAiVoice => sharedPreferences.getBool(Constants.TTS_USE_AI_VOICE) ?? true;

  bool get aiPredictionsEnabled => sharedPreferences.getBool(Constants.AI_PREDICTIONS_ENABLED) ?? false;

  String get aiPredictionProvider =>
      sharedPreferences.getString(Constants.AI_PREDICTION_PROVIDER) ?? 'gemini';

  void setFirstTime({required bool isFirstTime}) {
    sharedPreferences.setBool(Constants.FIRST_TIME, isFirstTime);
    notifyListeners();
  }

  //ignore: avoid_positional_boolean_parameters
  void setRelatedWordsEnabled(bool hasRelatedWordsEnabled) {
    sharedPreferences.setBool(Constants.RELATED_WORDS, hasRelatedWordsEnabled);
    notifyListeners();
  }

  void setBiometrics({required bool useBiometrics}) {
    sharedPreferences.setBool(Constants.BIOMETRIC_KEY, useBiometrics);
    notifyListeners();
  }

  void setEmail(String email) {
    sharedPreferences.setString(Constants.EMAIL_KEY, email);
    notifyListeners();
  }

  void setUserName(String userName) {
    sharedPreferences.setString(Constants.USER_FIRST_NAME, userName);
    notifyListeners();
  }

  void setUserLastName(String userLastName) {
    sharedPreferences.setString(Constants.USER_LAST_NAME, userLastName);
    notifyListeners();
  }

  void setThemeName(String themeName) {
    sharedPreferences.setString(Constants.THEME_NAME, themeName);
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    sharedPreferences.setString(Constants.THEME_MODE, mode.name);
    notifyListeners();
  }

  void setLanguageId(String languageId) {
    sharedPreferences.setString(Constants.LANGUAGE_ID, languageId);
    notifyListeners();
  }

  void setTtsPitch(double pitch) {
    sharedPreferences.setDouble(Constants.TTS_PITCH, pitch);
    notifyListeners();
  }

  void setTtsSpeechRate(double rate) {
    sharedPreferences.setDouble(Constants.TTS_SPEECH_RATE, rate);
    notifyListeners();
  }

  void setTtsVoice(String name, String locale) {
    sharedPreferences.setString(Constants.TTS_VOICE_NAME, name);
    sharedPreferences.setString(Constants.TTS_VOICE_LOCALE, locale);
    notifyListeners();
  }

  void clearTtsVoice() {
    sharedPreferences.remove(Constants.TTS_VOICE_NAME);
    sharedPreferences.remove(Constants.TTS_VOICE_LOCALE);
    notifyListeners();
  }

  void setTtsOpenAiVoice(String voice) {
    sharedPreferences.setString(Constants.TTS_OPENAI_VOICE, voice);
    notifyListeners();
  }

  void setHighlightWordsEnabled(bool value) {
    sharedPreferences.setBool(Constants.TTS_HIGHLIGHT_WORDS, value);
    notifyListeners();
  }

  void setUseAiVoice(bool value) {
    sharedPreferences.setBool(Constants.TTS_USE_AI_VOICE, value);
    notifyListeners();
  }

  void setAiPredictionsEnabled(bool value) {
    sharedPreferences.setBool(Constants.AI_PREDICTIONS_ENABLED, value);
    notifyListeners();
  }

  void setAiPredictionProvider(String provider) {
    sharedPreferences.setString(Constants.AI_PREDICTION_PROVIDER, provider);
    notifyListeners();
  }

  String get imageAlbum => sharedPreferences.getString(Constants.IMAGE_ALBUM) ?? 'core';

  void setImageAlbum(String album) {
    sharedPreferences.setString(Constants.IMAGE_ALBUM, album);
    notifyListeners();
  }

  static Future<bool> get firstTime => SharedPreferences.getInstance().then(
        (sharedPreferences) => sharedPreferences.getBool(Constants.FIRST_TIME) ?? true,
      );
}
