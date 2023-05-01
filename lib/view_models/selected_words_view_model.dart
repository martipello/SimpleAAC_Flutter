import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';

// enum SelectedWordListAction {
//   add, remove,
// }

class SelectedWordsViewModel {
  final selectedWords = BehaviorSubject<BuiltList<Word>>.seeded(
    BuiltList<Word>.of([]),
  );

  final predictions = BehaviorSubject<BuiltList<Word>>.seeded(
    BuiltList<Word>.of([]),
  );

  void dispose() {
    selectedWords.close();
    predictions.close();
  }

  void addSelectedWord(Word word) {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      selectedWords.add(
        words.rebuild(
          (wb) => wb.add(word),
        ),
      );
      setPredictions(word.predictionList);
    }
  }

  void removeSelectedWord(Word word) {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      selectedWords.add(
        words.rebuild(
          (wb) => wb.remove(word),
        ),
      );
    }
  }

  void setPredictions(BuiltList<Word> predictions) {
    this.predictions.add(
      predictions,
    );
  }

  void updatePositionSelectedWordList(int oldIndex, int newIndex) {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      if (oldIndex < words.length && newIndex < words.length - 1) {
        final word = words[oldIndex];
        selectedWords.add(
          words.rebuild(
            (wb) => wb
              ..remove(word)
              ..insert(newIndex, word),
          ),
        );
      }
    }
  }

  void clearSelectedWordList() {
    selectedWords.add(BuiltList<Word>());
  }
}
