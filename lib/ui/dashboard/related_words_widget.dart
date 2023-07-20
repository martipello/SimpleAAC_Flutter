import 'package:built_collection/built_collection.dart';
import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import '../shared_widgets/multi_image.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../services/shared_preferences_service.dart';
import '../shared_widgets/chip_group.dart';
import '../shared_widgets/simple_aac_chip.dart';
import '../shared_widgets/word_tile.dart';

typedef WordListCallBack = void Function(BuiltList<Word> word);
typedef WordIDListCallBack = void Function(BuiltList<String> word);

class RelatedWordsWidget extends StatelessWidget {
  RelatedWordsWidget({
    required this.relatedWords,
    required this.onRelatedWordSelected,
    final Key? key,
    this.onRelatedWordIdsChanged,
    this.isExpanded = false,
  }) : super(key: key);

  final BuiltList<Word> relatedWords;
  final WordIDListCallBack? onRelatedWordIdsChanged;
  final WordCallBack onRelatedWordSelected;
  final bool isExpanded;

  final _sharedPreferencesService = getIt.get<SharedPreferencesService>();

  @override
  Widget build(final BuildContext context) {
    return ChangeNotifierBuilder(
      notifier: _sharedPreferencesService,
      builder: (final context, final _, final __) {
        final hasRelatedWordsEnabled = _sharedPreferencesService.hasRelatedWordsEnabled;
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
        left: 12,
        right: 96,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: relatedWords.length,
      itemBuilder: (final context, final index) {
        final word = relatedWords[index];
        return _buildRelatedWordChip(
          word,
          onDeleteWordFunction(word),
        );
      },
      separatorBuilder: (final context, final index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }

  Widget _buildExpandedChipGroup() {
    return ChipGroup(
      chips: relatedWords
          .map(
            (final word) => _buildRelatedWordChip(
              word,
              onDeleteWordFunction(word),
            ),
          )
          .toList(),
    );
  }

  Widget _buildRelatedWordChip(
    final Word word,
    final VoidCallback? onDelete,
  ) {
    return SimpleAACChip(
      label: word.word,
      icon: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipOval(
          clipBehavior: Clip.hardEdge,
          child: MultiImage(
            images: word.imageList,
            fadeIn: false,
            spacing: 1,
          ),
        ),
      ),
      chipType: ChipType.normal,
      onTap: () {
        onRelatedWordSelected.call(word);
      },
      onDelete: onDelete,
    );
  }

  VoidCallback? onDeleteWordFunction(
    final Word word,
  ) {
    final onDeleteWord = onRelatedWordIdsChanged;
    if (onDeleteWord != null) {
      return () {
        onDeleteWord.call(
          relatedWords
              .rebuild(
                (final pb) => pb.remove(word),
              )
              .map((final p0) => p0.id)
              .toBuiltList(),
        );
      };
    } else {
      return null;
    }
  }
}
