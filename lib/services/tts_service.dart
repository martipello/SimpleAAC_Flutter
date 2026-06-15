import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/native_file_utils.dart';

import '../services/shared_preferences_service.dart';
import '../ui/dashboard/sentence_builder.dart';
import '../utils/constants.dart';

enum TtsVoiceQuality { premium, enhanced, standard }

class TtsVoice {
  const TtsVoice({
    required this.name,
    required this.locale,
    required this.displayName,
    required this.quality,
  });

  final String name;
  final String locale;
  final String displayName;
  final TtsVoiceQuality quality;

  static TtsVoice fromMap(Map raw) {
    final name = raw['name'] as String? ?? '';
    final locale = raw['locale'] as String? ?? '';
    final quality = _quality(name, raw['quality'] as String? ?? '');
    return TtsVoice(
      name: name,
      locale: locale,
      displayName: _displayName(name, locale),
      quality: quality,
    );
  }

  static String _displayName(String name, String locale) {
    // iOS: "com.apple.voice.premium.en-US.Zoe" → "Zoe"
    if (name.contains('.')) return name.split('.').last;
    // Android: derive a readable name from the locale, e.g. "en-US" → "English (US)"
    final parts = locale.split('-');
    if (parts.length >= 2) {
      return '${_languageName(parts[0])} (${parts[1]})';
    }
    return locale.isNotEmpty ? locale : name;
  }

  static String _languageName(String code) => switch (code.toLowerCase()) {
        'en' => 'English',
        'es' => 'Spanish',
        'fr' => 'French',
        'de' => 'German',
        'it' => 'Italian',
        'pt' => 'Portuguese',
        'nl' => 'Dutch',
        'ja' => 'Japanese',
        'ko' => 'Korean',
        'zh' => 'Chinese',
        'ar' => 'Arabic',
        _ => code.toUpperCase(),
      };

  static TtsVoiceQuality _quality(String name, String qualityField) {
    final combined = '${name.toLowerCase()} ${qualityField.toLowerCase()}';
    if (combined.contains('premium')) return TtsVoiceQuality.premium;
    if (combined.contains('enhanced') || combined.contains('neural')) {
      return TtsVoiceQuality.enhanced;
    }
    return TtsVoiceQuality.standard;
  }

  @override
  bool operator ==(Object other) =>
      other is TtsVoice && other.name == name && other.locale == locale;

  @override
  int get hashCode => Object.hash(name, locale);
}

class TtsService {
  TtsService(this._prefs, this._secureStorage) {
    _init();
  }

  final SharedPreferencesService _prefs;
  final FlutterSecureStorage _secureStorage;

  final _tts = FlutterTts();
  final _audioPlayer = AudioPlayer();
  final _highlightTimers = <Timer>[];

  SentencePlan? _currentPlan;
  bool _available = false;
  bool _usingAiVoice = false;

  final _highlightedSlotIds = BehaviorSubject<Set<int>>.seeded({});
  final _isSpeaking = BehaviorSubject<bool>.seeded(false);

  Stream<Set<int>> get highlightedSlotIds => _highlightedSlotIds.stream;
  Stream<bool> get isSpeaking => _isSpeaking.stream;
  bool get isSpeakingNow => _isSpeaking.value;

  Future<void> _init() async {
    try {
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
        await _tts.setSharedInstance(true);
        await _tts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers,
          ],
          IosTextToSpeechAudioMode.defaultMode,
        );
      }

      await _tts.setSpeechRate(_prefs.ttsSpeechRate);
      await _tts.setVolume(1.0);
      await _tts.setPitch(_prefs.ttsPitch);

      await _restoreOrSelectVoice();

      // Prime the OpenAI key if one is already saved.
      final savedKey = await getOpenAiKey();
      if (savedKey != null && savedKey.isNotEmpty) {
        OpenAI.apiKey = savedKey;
      }

      _tts.setCompletionHandler(() { if (!_usingAiVoice) _onDone(); });
      _tts.setCancelHandler(() { if (!_usingAiVoice) _onDone(); });
      _tts.setErrorHandler((_) { if (!_usingAiVoice) _onDone(); });

      _available = true;
    } on MissingPluginException {
      // Plugin not linked — TTS silently unavailable (e.g. during testing).
    } catch (_) {
      // Any other init failure; TTS unavailable but app continues.
    }

    // Audioplayers setup is separate so a MissingPluginException there
    // doesn't prevent platform TTS from working.
    try {
      _audioPlayer.onPlayerComplete.listen((_) { if (_usingAiVoice) _onDone(); });
    } catch (_) {}
  }

  void _onDone() {
    _cancelHighlightTimers();
    _isSpeaking.add(false);
    _highlightedSlotIds.add({});
    _currentPlan = null;
    _usingAiVoice = false;
  }

  // ── OpenAI key management ─────────────────────────────────────────────────

  Future<String?> getOpenAiKey() =>
      _secureStorage.read(key: Constants.OPENAI_API_KEY);

  Future<void> setOpenAiKey(String key) async {
    await _secureStorage.write(key: Constants.OPENAI_API_KEY, value: key);
    OpenAI.apiKey = key;
    _prefs.setUseAiVoice(true);
  }

  Future<void> clearOpenAiKey() async {
    await _secureStorage.delete(key: Constants.OPENAI_API_KEY);
    _prefs.setUseAiVoice(false);
  }

  Future<bool> hasOpenAiKey() async =>
      ((await getOpenAiKey())?.isNotEmpty) == true;

  // ── Platform voice management ─────────────────────────────────────────────

  Future<void> _restoreOrSelectVoice() async {
    try {
      final savedName = _prefs.ttsVoiceName;
      final savedLocale = _prefs.ttsVoiceLocale;
      if (savedName != null && savedLocale != null) {
        await _tts.setVoice({'name': savedName, 'locale': savedLocale});
        return;
      }
      final voices = await getVoices();
      if (voices.isNotEmpty) {
        final preferred = voices
                .where((v) => v.locale.toLowerCase() == 'en-gb')
                .firstOrNull ??
            voices
                .where((v) => v.locale.toLowerCase().startsWith('en'))
                .firstOrNull ??
            voices.first;
        await _tts.setVoice({'name': preferred.name, 'locale': preferred.locale});
      }
    } catch (_) {}
  }

  Future<List<TtsVoice>> getVoices() async {
    try {
      final raw = await _tts.getVoices as List?;
      if (raw == null || raw.isEmpty) return [];
      final voices = raw.cast<Map>().map(TtsVoice.fromMap).toList();
      voices.sort((a, b) => a.quality.index.compareTo(b.quality.index));
      return voices;
    } catch (_) {
      return [];
    }
  }

  Future<void> setVoice(TtsVoice voice) async {
    if (!_available) return;
    try {
      await _tts.setVoice({'name': voice.name, 'locale': voice.locale});
      _prefs.setTtsVoice(voice.name, voice.locale);
    } catch (_) {}
  }

  Future<TtsVoice?> resetVoice() async {
    _prefs.clearTtsVoice();
    await _restoreOrSelectVoice();
    final savedName = _prefs.ttsVoiceName;
    if (savedName == null) return null;
    final voices = await getVoices();
    return voices.where((v) => v.name == savedName).firstOrNull;
  }

  // ── Speak ─────────────────────────────────────────────────────────────────

  Future<void> speak(SentencePlan plan) async {
    if (!_available) return;
    try {
      _currentPlan = plan;
      _cancelHighlightTimers();
      await _tts.stop();
      await _audioPlayer.stop();
      _highlightedSlotIds.add({});
      _isSpeaking.add(true);

      final key = await getOpenAiKey();
      if (_prefs.useAiVoice && key != null && key.isNotEmpty) {
        _usingAiVoice = true;
        await _speakWithOpenAi(plan.ttsText, key, plan: plan);
      } else {
        _usingAiVoice = false;
        if (_prefs.highlightWordsEnabled) {
          _startEstimatedHighlighting(plan);
        }
        await _tts.speak(plan.ttsText);
      }
    } on MissingPluginException {
      _onDone();
    } catch (_) {
      _onDone();
    }
  }

  Future<void> speakWord(String text) async {
    if (!_available || text.trim().isEmpty) return;
    try {
      _currentPlan = null;
      _cancelHighlightTimers();
      await _tts.stop();
      await _audioPlayer.stop();
      _isSpeaking.add(true);

      final key = await getOpenAiKey();
      if (_prefs.useAiVoice && key != null && key.isNotEmpty) {
        _usingAiVoice = true;
        await _speakWithOpenAi(text.trim(), key);
      } else {
        _usingAiVoice = false;
        await _tts.speak(text.trim());
      }
    } on MissingPluginException {
      _onDone();
    } catch (_) {
      _onDone();
    }
  }

  Future<void> _speakWithOpenAi(String text, String apiKey, {SentencePlan? plan}) async {
    try {
      final speed = (_prefs.ttsSpeechRate / 0.44).clamp(0.25, 4.0);
      final path = await createOpenAiSpeechFile(text, _prefs.ttsOpenAiVoice, speed);

      if (path == null) {
        // Web or unsupported platform — fall back to platform TTS.
        _usingAiVoice = false;
        await _tts.speak(text);
        return;
      }

      // Start estimated highlighting now that we know playback is about to begin.
      if (plan != null && _prefs.highlightWordsEnabled) {
        _startEstimatedHighlighting(plan);
      }

      await _audioPlayer.play(DeviceFileSource(path));
    } catch (_) {
      // API error or no connectivity — fall back to platform TTS silently.
      _usingAiVoice = false;
      await _tts.speak(text);
    }
  }


  // ── Estimated word highlighting ───────────────────────────────────────────

  /// Schedules highlight updates based on each group's character position
  /// relative to the total text length and estimated speech rate.
  void _startEstimatedHighlighting(SentencePlan plan) {
    final totalChars = plan.ttsText.length;
    if (totalChars == 0 || plan.groups.isEmpty) return;

    // At rate=0.44 (normal), empirically ~12 chars/second.
    final charsPerSecond = 12.0 * (_prefs.ttsSpeechRate / 0.44);
    final totalMs = (totalChars / charsPerSecond * 1000).round();

    for (final group in plan.groups) {
      final delayMs = ((group.charStart / totalChars) * totalMs).round();
      _highlightTimers.add(
        Timer(Duration(milliseconds: delayMs), () {
          if (_isSpeaking.value) {
            _highlightedSlotIds.add(group.slotIds.toSet());
          }
        }),
      );
    }
  }

  void _cancelHighlightTimers() {
    for (final t in _highlightTimers) t.cancel();
    _highlightTimers.clear();
  }

  // ── Controls ──────────────────────────────────────────────────────────────

  Future<void> updatePitch(double pitch) async {
    if (!_available) return;
    try { await _tts.setPitch(pitch); } catch (_) {}
  }

  Future<void> updateSpeechRate(double rate) async {
    if (!_available) return;
    try { await _tts.setSpeechRate(rate); } catch (_) {}
  }

  Future<void> stop() async {
    _cancelHighlightTimers();
    if (!_available) return;
    try {
      await _tts.stop();
      await _audioPlayer.stop();
    } on MissingPluginException {
      // Nothing to stop.
    } catch (_) {
      // Ignore.
    } finally {
      _onDone();
    }
  }

  void dispose() {
    _cancelHighlightTimers();
    _audioPlayer.dispose();
    _highlightedSlotIds.close();
    _isSpeaking.close();
  }
}
