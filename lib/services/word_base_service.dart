import 'package:built_collection/built_collection.dart';
import '../ui/dashboard/related_words_widget.dart';

import '../api/models/word.dart';
import '../api/models/word_base.dart';
import '../api/models/word_sub_type.dart';
import 'language_service.dart';

class WordBaseService {
  WordBaseService(this.languageService);

  final LanguageService languageService;

  Future<BuiltList<WordBase>> getAllForType(final WordSubType wordSubType) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final allWordBases = [
      ...currentLanguage.words,
      ...currentLanguage.sentences,
      ...currentLanguage.wordGroups,
    ];
    return allWordBases.where((final w) => w.subType == wordSubType).toBuiltList();
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
}
