import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

import '../../../dependency_injection_container.dart';
import '../../services/sentence_service.dart';
import '../../services/word_service.dart';
import '../sentence.dart';
import '../word.dart';
import '../word_base.dart';
import '../word_group.dart';

const kWordIdPrefix = 'WordId-';
const kWordGroupIdPrefix = 'WordGroupId-';
const kSentenceIdPrefix = 'SentenceId-';
const kLanguageIdPrefix = 'LanguageId-';
const kImageInfoIdPrefix = 'ImageInfoId-';

extension WordExtension on WordBase {
  String getHeroTag(final String suffix) {
    return '$suffix$id';
  }

  Future<BuiltList<String>> getWords() async {
    final wordBase = this;
    if (wordBase is Word) {
      return Future.value(BuiltList.of([wordBase.word]));
    } else if (wordBase is Sentence) {
      final wordService = getIt.get<WordService>(instanceName: kWordBox);
      final words = await wordService.getForIds(wordBase.wordIds);
      return words.map((final word) => word.word).toBuiltList();
    }
    return Future.value(BuiltList());
  }

  Future<BuiltList<String>> getSounds() async {
    final wordBase = this;
    if (wordBase is Word) {
      return Future.value(BuiltList.of([wordBase.sound]));
    } else if (wordBase is Sentence) {
      final wordService = getIt.get<WordService>(instanceName: kSentenceBox);
      final words = await wordService.getForIds(wordBase.wordIds);
      return words.map((final word) => word.sound).toBuiltList();
    }
    return Future.value(BuiltList());
  }

  Future<BuiltList<Tuple2<String, String>>> getWordsAndSounds() async {
    final wordBase = this;
    if (wordBase is Word) {
      return Future.value(BuiltList.of([Tuple2(wordBase.word, wordBase.sound)]));
    } else if (wordBase is Sentence) {
      final wordService = getIt.get<WordService>(instanceName: kSentenceBox);
      final words = await wordService.getForIds(wordBase.wordIds);
      return words.map((final word) => Tuple2(word.word, word.sound)).toBuiltList();
    }
    return Future.value(BuiltList());
  }

  Future<BuiltList<Word>> getRelatedWords() async {
    final wordBase = this;
    final wordService = getIt.get<WordService>(instanceName: kWordBox);
    return wordService.getExtraRelatedWords(wordBase);
  }

  WordBase copy({final String? id}) {
    final wordBase = this;
    if (wordBase is Word) {
      return wordBase._fromWord(wordBase, id: id);
    } else if (wordBase is Sentence) {
      return wordBase._fromSentence(wordBase, id: id);
    } else {
      return wordBase;
    }
  }

  Word _fromWord(final Word word, {final String? id}) {
    return Word(
      (final b) => b
        ..id = id ?? word.id
        ..usageCount = word.usageCount
        ..type = word.type
        ..subType = word.subType
        ..word = word.word
        ..imageId = word.imageId
        ..sound = word.sound
        ..isFavourite = word.isFavourite
        ..keyStage = word.keyStage
        ..isUserAdded = word.isUserAdded
        ..isBackedUp = word.isBackedUp
        ..extraRelatedWordIds.replace(word.extraRelatedWordIds)
        ..createdDate = word.createdDate,
    );
  }

  Sentence _fromSentence(
    final Sentence sentence, {
    final String? id,
  }) {
    return Sentence(
      (final b) => b
        ..id = id ?? sentence.id
        ..usageCount = sentence.usageCount
        ..type = sentence.type
        ..subType = sentence.subType
        ..wordIds.replace(sentence.wordIds)
        ..isFavourite = sentence.isFavourite
        ..isUserAdded = sentence.isUserAdded
        ..isBackedUp = sentence.isBackedUp
        ..extraRelatedWordIds.replace(sentence.extraRelatedWordIds)
        ..createdDate = sentence.createdDate,
    );
  }

  bool isEqual(final WordBase otherWordBase) {
    final wordBase = this;
    if (wordBase.runtimeType != otherWordBase.runtimeType) {
      return false;
    }
    if (wordBase is Word) {
      final otherWord = otherWordBase as Word;
      return _isWordEqual(wordBase, otherWord);
    } else if (wordBase is Sentence) {
      final otherSentence = otherWordBase as Sentence;
      return _isSentenceEqual(wordBase, otherSentence);
    } else if (wordBase is WordGroup) {
      final otherWordGroup = otherWordBase as WordGroup;
      return _isWordGroupEqual(wordBase, otherWordGroup);
    } else {
      return false;
    }
  }

  bool _isWordEqual(
    final Word wordBase,
    final Word otherWord,
  ) {
    return wordBase.id == otherWord.id &&
        wordBase.sound == otherWord.sound &&
        wordBase.createdDate == otherWord.createdDate &&
        wordBase.usageCount == otherWord.usageCount &&
        wordBase.isFavourite == otherWord.isFavourite &&
        wordBase.isBackedUp == otherWord.isBackedUp &&
        wordBase.isUserAdded == otherWord.isUserAdded &&
        wordBase.type == otherWord.type &&
        wordBase.subType == otherWord.subType;
  }

  bool _isSentenceEqual(
    final Sentence wordBase,
    final Sentence otherSentence,
  ) {
    return wordBase.id == otherSentence.id &&
        wordBase.createdDate == otherSentence.createdDate &&
        wordBase.usageCount == otherSentence.usageCount &&
        wordBase.isFavourite == otherSentence.isFavourite &&
        wordBase.isBackedUp == otherSentence.isBackedUp &&
        wordBase.type == otherSentence.type &&
        wordBase.subType == otherSentence.subType;
  }

  bool _isWordGroupEqual(
    final WordGroup wordBase,
    final WordGroup otherWordGroup,
  ) {
    return wordBase.id == otherWordGroup.id &&
        wordBase.displayName == otherWordGroup.displayName &&
        wordBase.createdDate == otherWordGroup.createdDate &&
        wordBase.usageCount == otherWordGroup.usageCount &&
        wordBase.isFavourite == otherWordGroup.isFavourite &&
        wordBase.isBackedUp == otherWordGroup.isBackedUp &&
        listEquals(
          wordBase.wordIds.toList(),
          otherWordGroup.wordIds.toList(),
        ) &&
        wordBase.type == otherWordGroup.type &&
        wordBase.subType == otherWordGroup.subType;
  }
}
