import 'package:simple_aac/api/models/word.dart';
import 'package:simple_aac/api/models/word_base.dart';
import 'package:built_collection/built_collection.dart';

import '../sentence.dart';

extension WordExtension on WordBase {
  String getHeroTag(String suffix) {
    return '$suffix$id';
  }

  BuiltList<String> getImageList() {
    final wordBase = this;
    if (wordBase is Word) {
      return wordBase.imageList;
    } else if (wordBase is Sentence) {
      return BuiltList<String>.from(wordBase.words.map((word) => word.imageList.first));
    }
    return BuiltList<String>();
  }

  WordBase copy() {
    final wordBase = this;
    if(wordBase is Word) {
      return wordBase._fromWord(wordBase);
    } else if(wordBase is Sentence) {
      return wordBase._fromSentence(wordBase);
    } else {
      return wordBase;
    }
  }

  Word _fromWord(Word word) {
    return Word(
          (b) => b
        ..id = word.id
        ..usageCount = word.usageCount
        ..type = word.type
        ..subType = word.subType
        ..word = word.word
        ..imageList.replace(word.imageList)
        ..sound = word.sound
        ..isFavourite = word.isFavourite
        ..keyStage = word.keyStage
        ..isUserAdded = word.isUserAdded
        ..isBackedUp = word.isBackedUp
        ..extraRelatedWordIds.replace(word.extraRelatedWordIds)
        ..createdDate = word.createdDate,
    );
  }

  Sentence _fromSentence(Sentence sentence) {
    return Sentence(
          (b) => b
        ..id = sentence.id
        ..usageCount = sentence.usageCount
        ..type = sentence.type
        ..subType = sentence.subType
        ..words.replace(sentence.words)
        ..sound = sentence.sound
        ..isFavourite = sentence.isFavourite
        ..isUserAdded = sentence.isUserAdded
        ..isBackedUp = sentence.isBackedUp
        ..extraRelatedWordIds.replace(sentence.extraRelatedWordIds)
        ..createdDate = sentence.createdDate,
    );
  }
}
