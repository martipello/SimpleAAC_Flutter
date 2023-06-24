import 'package:built_collection/built_collection.dart';
import 'package:simple_aac/ui/dashboard/related_words_widget.dart';

import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import 'language_service.dart';

class WordService {
  WordService(this.languageService);

  final LanguageService languageService;

  Future<BuiltList<Word>> getAllForType(WordSubType wordSubType) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final words = currentLanguage.words;
    return words.where((w) => w.subType == wordSubType).toBuiltList();
  }

  Future<BuiltList<Word>> getExtraRelatedWords(Word word) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return currentLanguage.words
        .where(
          (lw) => word.extraRelatedWordIds.any(
            (w) => w == lw.wordId,
          ),
        )
        .toBuiltList();
  }

  Future<BuiltList<Word>> getRelatedWords(Word word) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final words = currentLanguage.words;
    final extraRelatedWords = await getExtraRelatedWords(word);
    //TODO make this actually get related words not just the related words on the word
    final relatedWords = words.where(
      (lw) => word.extraRelatedWordIds.any(
        (w) => w == lw.wordId,
      ),
    );
    return <Word>{...extraRelatedWords, ...relatedWords}.toBuiltList();
  }

  Future<BuiltList<Word>> getWordsForIds(BuiltList<String> wordIds) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return currentLanguage.words
        .where(
          (word) => wordIds.any(
            (id) => word.wordId == id,
          ),
        )
        .toBuiltList();
  }

  void addListener(WordListCallBack wordListCallBack) {
    languageService.addListener(
      _getWordListCallbackWrapper(wordListCallBack),
    );
  }

  void removeListener(WordListCallBack wordListCallBack) {
    languageService.removeListener(
      _getWordListCallbackWrapper(wordListCallBack),
    );
  }

  LanguageCallBack _getWordListCallbackWrapper(WordListCallBack wordListCallBack) {
    return (language) {
      wordListCallBack.call(language.words);
    };
  }
}
