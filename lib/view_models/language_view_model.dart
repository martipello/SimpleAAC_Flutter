import 'package:built_collection/built_collection.dart';

import '../api/models/language.dart';
import '../api/models/word.dart';
import '../api/services/language_service.dart';
import '../api/services/word_service.dart';

class LanguageViewModel {
  LanguageViewModel(
    this.languageService,
    this.wordService,
  );

  final LanguageService languageService;
  final WordService wordService;

  Future<Language> getCurrentLanguage() async {
    return languageService.getCurrentLanguage();
  }

  void setLanguage(final Language language) {
    languageService.setCurrentLanguage(language);
  }

  Future<BuiltList<Language>> allLanguages() async {
    return await languageService.getAll();
  }

  Future<BuiltList<Word>> firstTenForLanguage(final Language language) async {
    final words = await wordService.getAllForLanguage(language);
    final firstTen = words.take(10).toBuiltList();
    return Future.value(firstTen);
  }
}
