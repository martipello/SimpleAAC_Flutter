import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_aac/api/models/word_base.dart';

import '../api/models/word.dart';
import '../services/word_base_service.dart';

// enum SelectedWordListAction {
//   add, remove,
// }

class SelectedWordsViewModel {
  SelectedWordsViewModel(this.wordService);

  final WordBaseService wordService;

  final selectedWords = BehaviorSubject<BuiltList<WordBase>>.seeded(
    BuiltList<Word>.of([]),
  );

  final relatedWords = BehaviorSubject<BuiltList<Word>>.seeded(
    BuiltList<Word>.of([]),
  );

  void dispose() {
    selectedWords.close();
    relatedWords.close();
  }

  Future<void> addSelectedWord(WordBase word) async {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      selectedWords.add(
        words.rebuild(
          (wb) => wb.add(word),
        ),
      );
      if (word is Word) {
        final relatedWords = await wordService.getRelatedWords(word);
        setRelatedWords(relatedWords);
      }
    }
  }

  void removeSelectedWord(WordBase wordBase) {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      selectedWords.add(
        words.rebuild(
          (wb) => wb.remove(wordBase),
        ),
      );
    }
  }

  void setRelatedWords(BuiltList<Word> relatedWords) {
    this.relatedWords.add(relatedWords);
  }

  void setRelatedWordsForWordIds(BuiltList<String> relatedWords) async {
    final words = await wordService.getWordsForIds(relatedWords);
    setRelatedWords(words);
  }

  void updatePositionSelectedWordList(
    int oldIndex,
    int newIndex,
  ) {
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
