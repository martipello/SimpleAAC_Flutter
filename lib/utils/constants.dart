const double kMaxScreenWidth = 960;
const double kMinScreenWidth = 720;

class Constants {
  // ignore_for_file: constant_identifier_names
  static const USER_TOKEN_KEY = 'user_key';
  static const USER_ID = 'user_id';
  static const PROFILE_IMAGE = 'profile_image';
  static const USER_FIRST_NAME = 'user_first_name';
  static const USER_LAST_NAME = 'user_last_name';
  static const THEME_NAME = 'theme_name';
  static const THEME_MODE = 'theme_mode';
  static const PASSWORD_KEY = 'password_key';
  static const EMAIL_KEY = 'EMAIL_KEY';
  static const BIOMETRIC_KEY = 'use_biometric_key';
  static const FIRST_TIME = 'first_time';
  static const RELATED_WORDS = 'relatedWords';
  static const LANGUAGE_ID = 'languageId';
  static const TTS_PITCH = 'ttsPitch';
  static const TTS_SPEECH_RATE = 'ttsSpeechRate';
  static const TTS_VOICE_NAME = 'ttsVoiceName';
  static const TTS_VOICE_LOCALE = 'ttsVoiceLocale';
  static const TTS_OPENAI_VOICE = 'ttsOpenAiVoice';
  static const TTS_HIGHLIGHT_WORDS = 'ttsHighlightWords';
  static const TTS_USE_AI_VOICE = 'ttsUseAiVoice';
  // Stored in FlutterSecureStorage, not SharedPreferences.
  static const OPENAI_API_KEY = 'openai_api_key';
  static const GEMINI_API_KEY = 'gemini_api_key';
  // AI predictions toggle
  static const AI_PREDICTIONS_ENABLED = 'aiPredictionsEnabled';
  static const AI_PREDICTION_PROVIDER = 'aiPredictionProvider';
  static const IMAGE_ALBUM = 'imageAlbum';
}
