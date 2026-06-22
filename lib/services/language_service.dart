import 'dart:convert';

import 'package:flutter/services.dart';

import '../api/models/language.dart';
import '../api/models/language_response.dart';
import 'shared_preferences_service.dart';

const kDefaultLanguageId = 'en';

class LanguageService {
  LanguageService(this._prefs);

  final SharedPreferencesService _prefs;

  List<Language> _languages = [];

  String get currentLanguageId => _prefs.currentLanguageId;

  /// Load language metadata from the bundled asset. Call once at startup.
  Future<void> init() async {
    if (_languages.isNotEmpty) return;
    final raw = await rootBundle.loadString('assets/json/initial_word_data.json');
    final response = LanguageResponse.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
    // Keep only a preview slice of words — the full list lives in Drift.
    _languages = response.languages
        .map((l) => l.copyWith(words: l.words.take(10).toList()))
        .toList();
  }

  Language? getCurrentLanguage() =>
      _languages.where((l) => l.id == currentLanguageId).firstOrNull;

  List<Language> getAllLanguages() => _languages;

  void setCurrentLanguage(Language language) {
    _prefs.setLanguageId(language.id);
  }
}
