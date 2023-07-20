import 'package:built_collection/built_collection.dart';
import '../api/models/word_group.dart';

import '../api/models/word_sub_type.dart';
import 'language_service.dart';

typedef WordGroupListCallBack = void Function(BuiltList<WordGroup> wordGroups);

class SentenceService {
  SentenceService(this.languageService);

  final LanguageService languageService;

  Future<BuiltList<WordGroup>> getAllForType(final WordSubType wordSubType) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final wordGroups = currentLanguage.wordGroups;
    return wordGroups.where((final w) => w.subType == wordSubType).toBuiltList();
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

  Future<BuiltList<WordGroup>> getWordGroupsForIds(final BuiltList<String> ids) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    return currentLanguage.wordGroups
        .where(
          (final wordGroup) => ids.any(
            (final id) => wordGroup.id == id,
          ),
        )
        .toBuiltList();
  }

  void addListener(
    final WordGroupListCallBack wordGroupListCallBack,
  ) {
    languageService.addListener(
      _getSentenceListCallbackWrapper(
        wordGroupListCallBack,
      ),
    );
  }

  void removeListener(
    final WordGroupListCallBack wordGroupListCallBack,
  ) {
    languageService.removeListener(
      _getSentenceListCallbackWrapper(
        wordGroupListCallBack,
      ),
    );
  }

  LanguageCallBack _getSentenceListCallbackWrapper(
    final WordGroupListCallBack wordGroupListCallBack,
  ) {
    return (final language) {
      wordGroupListCallBack.call(
        language.wordGroups,
      );
    };
  }
}
