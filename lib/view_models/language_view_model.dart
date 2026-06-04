import '../api/models/language.dart';
import '../services/language_service.dart';

class LanguageViewModel {
  LanguageViewModel(this.languageService);

  final LanguageService languageService;

  Language? getCurrentLanguage() => languageService.getCurrentLanguage();

  void setLanguage(Language language) => languageService.setCurrentLanguage(language);

  List<Language> allLanguages() => languageService.getAllLanguages();
}
