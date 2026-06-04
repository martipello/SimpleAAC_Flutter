import '../api/models/language.dart';
import '../api/repositories/vocabulary_repository.dart';
import 'shared_preferences_service.dart';

const kDefaultLanguageId = 'en';

class LanguageService {
  LanguageService(this._vocabulary, this._prefs);

  final VocabularyRepository _vocabulary;
  final SharedPreferencesService _prefs;

  String get currentLanguageId => _prefs.currentLanguageId;

  Language? getCurrentLanguage() => _vocabulary
      .getAllLanguages()
      .where((l) => l.id == currentLanguageId)
      .firstOrNull;

  List<Language> getAllLanguages() => _vocabulary.getAllLanguages();

  void setCurrentLanguage(Language language) {
    _prefs.setLanguageId(language.id);
  }
}
