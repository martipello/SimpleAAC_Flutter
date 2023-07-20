import '../word.dart';
import '../word_base.dart';
import 'package:built_collection/built_collection.dart';
import '../word_group.dart';

import '../sentence.dart';

extension WordExtension on WordBase {
  String getHeroTag(final String suffix) {
    return '$suffix$id';
  }

  BuiltList<String> getImageList() {
    final wordBase = this;
    if (wordBase is Word) {
      return wordBase.imageList;
    } else if (wordBase is Sentence) {
      return BuiltList<String>.from(
        wordBase.words.map(
          (final word) => word.imageList.first,
        ),
      );
    } else if (wordBase is WordGroup) {
      return BuiltList<String>.from(
        wordBase.words.map(
          (final word) => word.getImageList().first,
        ),
      );
    }
    return BuiltList<String>();
  }

  BuiltList<String> getWords() {
    final wordBase = this;
    if (wordBase is Word) {
      return BuiltList<String>.of([wordBase.word]);
    } else if (wordBase is Sentence) {
      return wordBase.words.map((final word) => word.word).toBuiltList();
    }
    return BuiltList<String>();
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

  Sentence _fromSentence(final Sentence sentence, {final String? id}) {
    return Sentence(
      (final b) => b
        ..id = id ?? sentence.id
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
