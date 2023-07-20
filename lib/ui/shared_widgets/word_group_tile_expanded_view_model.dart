import 'package:rxdart/rxdart.dart';
import '../../api/models/word_group.dart';

class WordGroupTileExpandedViewModel {
  final isExpanded = BehaviorSubject<bool>.seeded(false);
  final selectedWordGroup = BehaviorSubject<WordGroup>();

  void setWordGroup(final WordGroup wordGroup) {
    selectedWordGroup.add(wordGroup);
  }

  void toggleExpandedUIState() {
    if (isExpanded.value) {
      isExpanded.add(false);
    } else {
      isExpanded.add(true);
    }
  }

  void dispose() {
    isExpanded.close();
    selectedWordGroup.close();
  }
}
