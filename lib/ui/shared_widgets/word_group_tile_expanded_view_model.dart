import 'package:rxdart/rxdart.dart';

import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/word_base.dart';
import '../../api/models/word_group.dart';
import '../../services/word_service.dart';

class WordGroupTileExpandedViewModel {
  WordGroupTileExpandedViewModel(
    this.wordBaseService,
  );

  final WordBaseService wordBaseService;

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
      wordBaseService.updateWordGroup(changedWordGroup);
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

  void removeWord(final WordBase word) {
    final changedWordGroup = this.changedWordGroup.valueOrNull;
    if (changedWordGroup != null) {
      this.changedWordGroup.add(
            changedWordGroup.rebuild(
              (final wg) => wg.words.remove(word),
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
}
