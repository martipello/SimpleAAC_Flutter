import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';

// enum SelectedWordListAction {
//   add, remove,
// }

class SelectedWordsViewModel {
  final selectedWordsStream = BehaviorSubject<List<Word>>();
  final predictionsForSelectedWord = BehaviorSubject<List<Word>>();

  void dispose() {
    selectedWordsStream.close();
    predictionsForSelectedWord.close();
  }

  void addSelectedWord(Word? word) {
    if (word != null) {
      final words = selectedWordsStream.value ?? [];
      words.add(word);
      selectedWordsStream.add(words);
    }
  }

  void removeSelectedWord(Word? word) {
    if (word != null) {
      final words = selectedWordsStream.value ?? [];
      words.remove(word);
      selectedWordsStream.add(words);
    }
  }

  void updatePositionSelectedWordList(int oldIndex, int newIndex) {
    final words = selectedWordsStream.value ?? [];
    if (oldIndex < words.length && newIndex < words.length - 1) {
      final word = words[oldIndex];
      words.remove(word);
      words.insert(newIndex, word);
      selectedWordsStream.add(words);
    }
  }

  void clearSelectedWordList() {
    selectedWordsStream.add([]);
  }
}
