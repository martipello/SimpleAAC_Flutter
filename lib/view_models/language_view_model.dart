import 'package:built_collection/built_collection.dart';

import '../api/models/language.dart';
import '../services/language_service.dart';

class LanguageViewModel {
  LanguageViewModel(this.languageService);

  final LanguageService languageService;

  Future<Language> getCurrentLanguage() async {
    return languageService.getCurrentLanguage();
  }

  void setLanguage(Language language) {
    languageService.setCurrentLanguage(language);
  }

  Future<BuiltList<Language>> allLanguages() async {
    return await languageService.getAll();
  }
}