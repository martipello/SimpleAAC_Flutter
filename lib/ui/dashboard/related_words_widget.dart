import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/iterable_extension.dart';
import '../../services/shared_preferences_service.dart';
import '../shared_widgets/chip_group.dart';
import '../shared_widgets/simple_aac_chip.dart';

typedef WordListCallBack = void Function(BuiltList<String> word);

class RelatedWordsWidget extends StatelessWidget {
  RelatedWordsWidget({
    Key? key,
    required this.relatedWords,
    this.onRelatedWordIdsChanged,
    this.isExpanded = false,
  }) : super(key: key);

  final BuiltList<Word> relatedWords;
  final WordListCallBack? onRelatedWordIdsChanged;
  final bool isExpanded;

  final sharedPreferences = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      initialData: sharedPreferences.hasRelatedWordsEnabled(),
      stream: sharedPreferences.relatedWordsEnabled,
      builder: (context, snapshot) {
        final hasRelatedWordsEnabled = snapshot.data ?? sharedPreferences.hasRelatedWordsEnabled();
        if (hasRelatedWordsEnabled) {
          return isExpanded ? _buildExpandedChipGroup() : _buildRelatedWordListView();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildRelatedWordListView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 4,
        right: 96,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: relatedWords.length,
      itemBuilder: (context, index) {
        final word = relatedWords[index];
        return _buildRelatedWordChip(
          word,
          _getAddRelatedWordFunction(word),
          _getRemoveRelatedWordFunction(word),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }

  VoidCallback? _getAddRelatedWordFunction(
    Word word,
  ) {
    if (onRelatedWordIdsChanged != null) {
      return () {
        onRelatedWordIdsChanged?.call(
          relatedWords
              .rebuild(
                (pb) => pb.add(word),
              )
              .map(
                (p0) => p0.wordId,
              )
              .toBuiltList(),
        );
      };
    } else {
      return null;
    }
  }

  VoidCallback? _getRemoveRelatedWordFunction(
    Word word,
  ) {
    if (onRelatedWordIdsChanged != null) {
      return () {
        onRelatedWordIdsChanged?.call(
          relatedWords
              .rebuild(
                (pb) => pb.remove(word),
              )
              .map(
                (p0) => p0.wordId,
              )
              .toBuiltList(),
        );
      };
    } else {
      return null;
    }
  }

  Widget _buildExpandedChipGroup() {
    return ChipGroup(
      chips: relatedWords
          .map(
            (word) => _buildRelatedWordChip(
              word,
              _getAddRelatedWordFunction(word),
              _getRemoveRelatedWordFunction(word),
            ),
          )
          .toList(),
    );
  }

  Widget _buildRelatedWordChip(
    Word word,
    VoidCallback? onTap,
    VoidCallback? onDelete,
  ) {
    return SimpleAACChip(
      label: word.word,
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipOval(
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            word.imageList.firstOrNull() ?? 'assets/images/simple_aac_white_background.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      chipType: ChipType.normal,
      onTap: onTap,
      onDelete: onDelete,
    );
  }
}
