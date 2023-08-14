import 'package:rxdart/rxdart.dart';

import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/word_base.dart';
import '../../api/models/word_group.dart';
import '../../api/services/sentence_service.dart';
import '../../api/services/word_group_service.dart';
import '../../api/services/word_service.dart';
import '../../extensions/string_extension.dart';

class WordGroupTileExpandedViewModel {
  WordGroupTileExpandedViewModel(
    this.wordService,
    this.wordGroupService,
    this.sentenceService,
  );

  final WordGroupService wordGroupService;
  final WordService wordService;
  final SentenceService sentenceService;

  final hasWordGroupChanged = BehaviorSubject<bool>.seeded(false);
  final initialWordGroup = BehaviorSubject<WordGroup>();
  final changedWordGroup = BehaviorSubject<WordGroup>();

  void setInitialWordGroup(final WordGroup wordGroup) {
    initialWordGroup.add(wordGroup);
  }

  void setChangedWordGroup(final WordGroup wordGroup) {
    changedWordGroup.add(wordGroup);
  }

  void saveChanges() {
    final changedWordGroup = this.changedWordGroup.valueOrNull;
    if (changedWordGroup != null) {
      initialWordGroup.add(changedWordGroup);
      wordGroupService.put(changedWordGroup);
    }
  }

  void discardChanges() {
    final initialWordGroup = this.initialWordGroup.valueOrNull;
    if (initialWordGroup != null) {
      changedWordGroup.add(initialWordGroup);
    }
  }

  void updateTitle(final String displayName) {
    final changedWordGroup = this.changedWordGroup.valueOrNull;
    if (changedWordGroup != null) {
      this.changedWordGroup.add(
            changedWordGroup.rebuild(
              (final wg) => wg.displayName = displayName,
            ),
          );
    }
  }

  void removeWord(final String wordId) {
    final changedWordGroup = this.changedWordGroup.valueOrNull;
    if (changedWordGroup != null) {
      this.changedWordGroup.add(
            changedWordGroup.rebuild(
              (final wg) => wg.wordIds.remove(wordId),
            ),
          );
    }
  }

  void validateForWordGroupChanges() {
    final initialWordGroup = this.initialWordGroup.valueOrNull;
    final changedWordGroup = this.changedWordGroup.valueOrNull;
    if (changedWordGroup != null && initialWordGroup?.isEqual(changedWordGroup) == true) {
      hasWordGroupChanged.add(true);
    } else {
      hasWordGroupChanged.add(false);
    }
  }

  void dispose() {
    hasWordGroupChanged.close();
    initialWordGroup.close();
    changedWordGroup.close();
  }

  Future<WordBase?> getWord(final String wordId) async {
    //TODO this needs to know what it is getting, ie word or sentence
    //Make id identifier a constant
    if (wordId.isWordId()) {
      return wordService.get(wordId);
    } else if (wordId.isSentenceId()) {
      return sentenceService.get(wordId);
    } else {
      return null;
    }
  }
}
