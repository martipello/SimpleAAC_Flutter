import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';

class CreateWordViewModel {
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

  void addWordPrediction(Word word) {
    final predictions = wordStream.valueOrNull?.predictionList;
    if (predictions != null) {
      setWordPredictions(
        predictions.rebuild(
          (pb) => pb.add(word),
        ),
      );
    } else {
      setWordPredictions(
        [word].toBuiltList(),
      );
    }
  }

  void removeWordPrediction(Word word) {
    final predictions = wordStream.valueOrNull?.predictionList;
    if (predictions != null) {
      setWordPredictions(
        predictions.rebuild(
          (pb) => pb.remove(word),
        ),
      );
    }
  }

  void setWordPredictions(BuiltList<Word?> predictions) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(
        word.rebuild(
          (p0) => p0.predictionList = predictions.toBuiltList().toBuilder(),
        ),
      );
    } else {
      wordStream.add(
        Word(
          (p0) => p0.predictionList = predictions.toBuiltList().toBuilder(),
        ),
      );
    }
  }

  void dispose() {
    wordStream.close();
  }
}
