import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../services/word_base_service.dart';

class ManageWordViewModel {
  ManageWordViewModel(this.wordService);

  final WordBaseService wordService;

  final wordStream = BehaviorSubject<Word?>();

  void setWord(Word? word) {
    wordStream.add(word);
  }

  void setWordSubType(WordSubType? wordSubType) {
    final word = wordStream.value;
    if (word != null) {
      wordStream.add(
        word.rebuild((p0) => p0.subType = wordSubType),
      );
    } else {
      wordStream.add(
        Word((p0) => p0.subType = wordSubType),
      );
    }
  }

  void setWordType(WordType? wordType) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((p0) => p0.type = wordType),
      );
    } else {
      wordStream.add(
        Word((p0) => p0.type = wordType),
      );
    }
  }

  void setWordWord(String? wordWord) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((p0) => p0.word = wordWord),
      );
    } else {
      wordStream.add(
        Word((p0) => p0.word = wordWord),
      );
    }
  }

  void setWordDescription(String? wordWord) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((p0) => p0.word = wordWord),
      );
    } else {
      wordStream.add(
        Word((p0) => p0.word = wordWord),
      );
    }
  }

  void setWordSound(String? sound) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((p0) => p0.sound = sound),
      );
    } else {
      wordStream.add(
        Word((p0) => p0.sound = sound),
      );
    }
  }

  void setExtraRelatedWords(BuiltList<String> relatedWordIds) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild(
          (p0) => p0.extraRelatedWordIds.replace(relatedWordIds),
        ),
      );
    } else {
      wordStream.add(
        Word(
          (p0) => p0.extraRelatedWordIds.replace(relatedWordIds),
        ),
      );
    }
  }

  Stream<BuiltList<Word>> get relatedWords => wordStream.whereType<Word>().switchMap((word) {
    return wordService.getRelatedWords(word).asStream();
  });

  Stream<BuiltList<Word>> get extraRelatedWords => wordStream.whereType<Word>().switchMap((word) {
    return wordService.getExtraRelatedWords(word).asStream();
  });

  void dispose() {
    wordStream.close();
  }
}
