import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import '../api/models/extensions/word_base_extension.dart';
import '../api/models/word_base.dart';
import '../extensions/iterable_extension.dart';

import '../api/models/word.dart';
import '../api/services/word_service.dart';

// enum SelectedWordListAction {
//   add, remove,
// }

class SelectedWordsViewModel {
  SelectedWordsViewModel(this.wordService);

  final WordService wordService;

  final selectedWords = BehaviorSubject<BuiltList<WordBase>>.seeded(
    BuiltList<WordBase>.of([]),
  );

  final relatedWords = BehaviorSubject<BuiltList<Word>>.seeded(
    BuiltList<Word>.of([]),
  );

  void dispose() {
    selectedWords.close();
    relatedWords.close();
  }

  Future<void> addSelectedWord(final WordBase word) async {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      selectedWords.add(
        words.rebuild(
          (final wb) => wb.add(
            word.copy(
              //Here we give it a new id so that duplicate words can be added to the list
              // and the lists animation comparator will still work
              id: (words.length + 1).toString(),
            ),
          ),
        ),
      );
      if (word is Word) {
        final relatedWords = await word.getRelatedWords();
        setRelatedWords(relatedWords);
      }
    }
  }

  void removeSelectedWord(final WordBase wordBase) {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      final wordToRemove = words.firstWhereOrNull(
        (final word) => word.id == wordBase.id,
      );
      if (wordToRemove != null) {
        selectedWords.add(
          words.rebuild(
            (final wb) => wb.remove(wordToRemove),
          ),
        );
      }
    }
  }

  void updatePositionSelectedWordList(
    final int oldIndex,
    final int newIndex,
  ) {
    final words = selectedWords.valueOrNull;
    if (words != null) {
      final word = words[oldIndex];
      selectedWords.add(
        words.rebuild(
          (final wb) => wb
            ..remove(word)
            ..insert(newIndex, word),
        ),
      );
    }
  }

  void setRelatedWords(final BuiltList<Word> relatedWords) {
    this.relatedWords.add(relatedWords);
  }

  void setRelatedWordsForWordIds(final BuiltList<String> relatedWords) async {
    final words = await wordService.getForIds(relatedWords);
    setRelatedWords(words);
  }

  void clearSelectedWordList() {
    selectedWords.add(BuiltList<Word>());
  }
}
