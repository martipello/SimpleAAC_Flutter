import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/iterable_extension.dart';
import '../../services/shared_preferences_service.dart';
import '../shared_widgets/chip_group.dart';
import '../shared_widgets/simple_aac_chip.dart';
import '../shared_widgets/word_image.dart';

typedef WordCallBack = void Function(Word word);
typedef WordListCallback = void Function(List<Word> words);
typedef WordIDListCallback = void Function(List<String> ids);

class RelatedWordsWidget extends StatelessWidget {
  RelatedWordsWidget({
    super.key,
    required this.relatedWords,
    required this.onRelatedWordSelected,
    this.onRelatedWordIdsChanged,
    this.isExpanded = false,
  });

  final List<Word> relatedWords;
  final WordIDListCallback? onRelatedWordIdsChanged;
  final WordCallBack onRelatedWordSelected;
  final bool isExpanded;

  final _sharedPreferencesService = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _sharedPreferencesService,
      builder: (context, _) {
        if (!_sharedPreferencesService.hasRelatedWordsEnabled) {
          return const SizedBox.shrink();
        }
        return isExpanded
            ? _buildExpandedChipGroup()
            : _buildRelatedWordListView();
      },
    );
  }

  Widget _buildRelatedWordListView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 16, right: 96),
      scrollDirection: Axis.horizontal,
      itemCount: relatedWords.length,
      itemBuilder: (context, index) {
        final word = relatedWords[index];
        return _buildRelatedWordChip(word, _onDeleteWord(word));
      },
      separatorBuilder: (_, __) => const SizedBox(width: 12),
    );
  }

  Widget _buildExpandedChipGroup() {
    return ChipGroup(
      chips: relatedWords
          .map((word) => _buildRelatedWordChip(word, _onDeleteWord(word)))
          .toList(),
    );
  }

  Widget _buildRelatedWordChip(Word word, VoidCallback? onDelete) {
    return SimpleAACChip(
      label: word.text,
      icon: ClipOval(
        child: _buildWordImage(word),
      ),
      chipType: ChipType.normal,
      onTap: () => onRelatedWordSelected(word),
      onDelete: onDelete,
    );
  }

  Widget _buildWordImage(Word word) => WordImage(
        imagePath: word.imagePaths.firstOrNull(),
        fit: BoxFit.cover,
        width: 24,
        height: 24,
      );

  VoidCallback? _onDeleteWord(Word word) {
    final callback = onRelatedWordIdsChanged;
    if (callback == null) return null;
    return () {
      final remaining = relatedWords
          .where((w) => w.wordId != word.wordId)
          .map((w) => w.wordId)
          .toList();
      callback(remaining);
    };
  }
}
