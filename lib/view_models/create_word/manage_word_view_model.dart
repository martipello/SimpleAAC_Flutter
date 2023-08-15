import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../api/services/word_service.dart';

class ManageWordViewModel {
  ManageWordViewModel(this.wordService);

  final WordService wordService;

  final wordStream = BehaviorSubject<Word?>();

  void setWord(final Word? word) {
    wordStream.add(word);
  }

  void setWordSubType(final WordSubType? wordSubType) {
    final word = wordStream.value;
    if (word != null) {
      wordStream.add(
        word.rebuild((final p0) => p0.subType = wordSubType),
      );
    } else {
      wordStream.add(
        Word((final p0) => p0.subType = wordSubType),
      );
    }
  }

  void setWordType(final WordType? wordType) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((final p0) => p0.type = wordType),
      );
    } else {
      wordStream.add(
        Word((final p0) => p0.type = wordType),
      );
    }
  }

  void setWordWord(final String? wordWord) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((final p0) => p0.word = wordWord),
      );
    } else {
      wordStream.add(
        Word((final p0) => p0.word = wordWord),
      );
    }
  }

  void setWordDescription(final String? wordWord) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((final p0) => p0.word = wordWord),
      );
    } else {
      wordStream.add(
        Word((final p0) => p0.word = wordWord),
      );
    }
  }

  void setWordSound(final String? sound) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild((final p0) => p0.sound = sound),
      );
    } else {
      wordStream.add(
        Word((final p0) => p0.sound = sound),
      );
    }
  }

  void setExtraRelatedWords(final BuiltList<String> relatedWordIds) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild(
          (final p0) => p0.extraRelatedWordIds.replace(relatedWordIds),
        ),
      );
    } else {
      wordStream.add(
        Word(
          (final p0) => p0.extraRelatedWordIds.replace(relatedWordIds),
        ),
      );
    }
  }

  Stream<BuiltList<Word>> get relatedWords => wordStream.whereType<Word>().switchMap((final word) {
    return word.getRelatedWords().asStream();
  });

  Stream<BuiltList<Word>> get extraRelatedWords => wordStream.whereType<Word>().switchMap((final word) {
    return wordService.getExtraRelatedWords(word).asStream();
  });

  void dispose() {
    wordStream.close();
  }
}
