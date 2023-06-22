import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/language.dart';
import '../services/language_service.dart';

class LanguageViewModel {
  LanguageViewModel(this.languageService);

  final LanguageService languageService;

  void init() {
    addCurrentLanguageListener();
    _currentLanguageListener();
  }

  final currentLanguage = BehaviorSubject<Language?>();

  void addCurrentLanguageListener() {
    languageService.addListener(_currentLanguageListener);
  }

  Future<void> _currentLanguageListener() async {
    final language = await languageService.getCurrentLanguage();
    currentLanguage.add(language);
  }

  Future<void> setLanguage(Language language) async {
    return languageService.put(language);
  }

  Future<BuiltList<Language>> allLanguages() async {
    return await languageService.getAll();
  }

  void dispose() {
    currentLanguage.close();
    languageService.removeListener(_currentLanguageListener);
  }
}