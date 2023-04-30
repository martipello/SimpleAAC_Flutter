import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';

// enum SelectedWordListAction {
//   add, remove,
// }

class SelectedWordsViewModel {
  final selectedWordsStream = BehaviorSubject<BuiltList<Word>>.seeded(
    BuiltList<Word>.of([]),
  );

  final predictionsForSelectedWord = BehaviorSubject<BuiltList<Word>>.seeded(
    BuiltList<Word>.of([]),
  );

  void dispose() {
    selectedWordsStream.close();
    predictionsForSelectedWord.close();
  }

  void addSelectedWord(Word word) {
    final words = selectedWordsStream.value;
    selectedWordsStream.add(
      words.rebuild(
        (wb) => wb.add(word),
      ),
    );
  }

  void removeSelectedWord(Word? word) {
    final words = selectedWordsStream.value;
    selectedWordsStream.add(
      words.rebuild(
        (wb) => wb.remove(word),
      ),
    );
  }

  void updatePositionSelectedWordList(int oldIndex, int newIndex) {
    final words = selectedWordsStream.value;
    if (oldIndex < words.length && newIndex < words.length - 1) {
      final word = words[oldIndex];
      selectedWordsStream.add(
        words.rebuild(
          (wb) => wb
            ..remove(word)
            ..insert(newIndex, word),
        ),
      );
    }
  }

  void clearSelectedWordList() {
    selectedWordsStream.add(BuiltList<Word>());
  }
}
