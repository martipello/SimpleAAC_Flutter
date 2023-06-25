import 'package:built_collection/built_collection.dart';
import 'package:simple_aac/api/models/word_group.dart';

import '../api/models/word_sub_type.dart';
import 'language_service.dart';

typedef WordGroupListCallBack = void Function(BuiltList<WordGroup> wordGroups);

class SentenceService {
  SentenceService(this.languageService);

  final LanguageService languageService;

  Future<BuiltList<WordGroup>> getAllForType(WordSubType wordSubType) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final wordGroups = currentLanguage.wordGroups;
    return wordGroups.where((w) => w.subType == wordSubType).toBuiltList();
  }

  // Future<BuiltList<Sentence>> getExtraRelatedWords(Sentence sentence) async {
  //   final currentLanguage = await languageService.getCurrentLanguage();
  //   return currentLanguage.sentences
  //       .where(
  //         (lw) => sentence.extraRelatedWordIds.any(
  //           (w) => w == lw.id,
  //         ),
  //       )
  //       .toBuiltList();
  // }

  // Future<BuiltList<Word>> getRelatedWords(Sentence sentence) async {
  //   final currentLanguage = await languageService.getCurrentLanguage();
  //   final sentences = currentLanguage.sentences;
  //   final extraRelatedWords = await getExtraRelatedWords(sentence);
  //   //TODO make this actually get related words not just the related words on the word
  //   final relatedWords = sentences.where(
  //     (lw) => sentence.extraRelatedWordIds.any(
  //       (w) => w == lw.id,
  //     ),
  //   );
  //   return <Word>{...extraRelatedWords, ...relatedWords}.toBuiltList();
  // }

  Future<BuiltList<WordGroup>> getWordGroupsForIds(BuiltList<String> ids) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return currentLanguage.wordGroups
        .where(
          (wordGroup) => ids.any(
            (id) => wordGroup.id == id,
          ),
        )
        .toBuiltList();
  }

  void addListener(
    WordGroupListCallBack wordGroupListCallBack,
  ) {
    languageService.addListener(
      _getSentenceListCallbackWrapper(
        wordGroupListCallBack,
      ),
    );
  }

  void removeListener(
    WordGroupListCallBack wordGroupListCallBack,
  ) {
    languageService.removeListener(
      _getSentenceListCallbackWrapper(
        wordGroupListCallBack,
      ),
    );
  }

  LanguageCallBack _getSentenceListCallbackWrapper(
    WordGroupListCallBack wordGroupListCallBack,
  ) {
    return (language) {
      wordGroupListCallBack.call(
        language.wordGroups,
      );
    };
  }
}
