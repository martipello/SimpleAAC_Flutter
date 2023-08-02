import 'package:built_collection/built_collection.dart';
import 'package:simple_aac/services/shared_preferences_service.dart';
import '../api/hive_client.dart';
import '../ui/dashboard/related_words_widget.dart';

import '../api/models/word.dart';
import '../api/models/word_base.dart';
import '../api/models/word_sub_type.dart';
import 'language_service.dart';

class WordBaseService {
  WordBaseService(
    this.hiveClient,
    this.sharedPreferencesService,
  );

  final HiveClient hiveClient;
  final SharedPreferencesService sharedPreferencesService;

  String get currentLanguageId => sharedPreferencesService.currentLanguageId;

  Future<void> put(final Word word) {
    return hiveClient.put(
      word.id,
      word,
    );
  }

  Future<void> putAll(final BuiltList<Word> words) async {
    for (var word in words) {
      await hiveClient.put(
        word.id,
        word,
      );
    }
  }

  Future<void> delete(final Word word) {
    return hiveClient.delete(word.id);
  }

  Future<Word?> get(final String wordId) {
    return hiveClient.get(wordId);
  }

  Future<BuiltList<Word>> getAll() async {
    return hiveClient.getAll();
  }

  //TODO() IMPORTANT!!! quite sure this needs re architecting to sqflite

  Future<BuiltList<WordBase>> getAllForType(final WordSubType wordSubType) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return getAll().where((final w) => w.subType == wordSubType).toBuiltList();
  }

  Future<BuiltList<Word>> getExtraRelatedWords(final Word word) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return currentLanguage.words
        .where(
          (final lw) => word.extraRelatedWordIds.any(
            (final w) => w == lw.id,
          ),
        )
        .toBuiltList();
  }

  Future<BuiltList<Word>> getRelatedWords(final Word word) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final words = currentLanguage.words;
    final extraRelatedWords = await getExtraRelatedWords(word);
    //TODO make this actually get related words not just the related words on the word
    final relatedWords = words.where(
      (final lw) => word.extraRelatedWordIds.any(
        (final w) => w == lw.id,
      ),
    );
    return <Word>{...extraRelatedWords, ...relatedWords}.toBuiltList();
  }

  Future<BuiltList<Word>> getWordsForIds(final BuiltList<String> wordIds) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return currentLanguage.words
        .where(
          (final word) => wordIds.any(
            (final id) => word.id == id,
          ),
        )
        .toBuiltList();
  }

  void updateWordGroup(final WordGroup wordGroup) {
    languageService.updateWordGroup(wordGroup);
  }

  void addListener(final WordListCallBack wordListCallBack) {
    languageService.addListener(
      _getWordListCallbackWrapper(wordListCallBack),
    );
  }

  void removeListener(
    final WordListCallBack wordListCallBack,
  ) {
    languageService.removeListener(
      _getWordListCallbackWrapper(
        wordListCallBack,
      ),
    );
  }

  LanguageCallBack _getWordListCallbackWrapper(
    final WordListCallBack wordListCallBack,
  ) {
    return (final language) {
      wordListCallBack.call(
        language.words,
      );
    };
  }

  void dispose() {
    hiveClient.dispose();
  }
}
