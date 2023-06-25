import 'package:built_collection/built_collection.dart';
import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/iterable_extension.dart';
import '../../services/shared_preferences_service.dart';
import '../shared_widgets/chip_group.dart';
import '../shared_widgets/simple_aac_chip.dart';
import '../shared_widgets/word_tile.dart';

typedef WordListCallBack = void Function(BuiltList<Word> word);
typedef WordIDListCallBack = void Function(BuiltList<String> word);

class RelatedWordsWidget extends StatelessWidget {
  RelatedWordsWidget({
    Key? key,
    required this.relatedWords,
    required this.onRelatedWordSelected,
    this.onRelatedWordIdsChanged,
    this.isExpanded = false,
  }) : super(key: key);

  final BuiltList<Word> relatedWords;
  final WordIDListCallBack? onRelatedWordIdsChanged;
  final WordCallBack onRelatedWordSelected;
  final bool isExpanded;

  final _sharedPreferencesService = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierBuilder(
      notifier: _sharedPreferencesService,
      builder: (context, _, __) {
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
        left: 4,
        right: 96,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: relatedWords.length,
      itemBuilder: (context, index) {
        final word = relatedWords[index];
        return _buildRelatedWordChip(
          word,
          onDeleteWordFunction(word),
        );
      },
      separatorBuilder: (context, index) {
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
            (word) => _buildRelatedWordChip(
              word,
              onDeleteWordFunction(word),
            ),
          )
          .toList(),
    );
  }

  Widget _buildRelatedWordChip(
    Word word,
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
      onTap: () {
        onRelatedWordSelected.call(word);
      },
      onDelete: onDelete,
    );
  }

  VoidCallback? onDeleteWordFunction(
    Word word,
  ) {
    final onDeleteWord = onRelatedWordIdsChanged;
    if (onDeleteWord != null) {
      return () {
        onDeleteWord.call(
          relatedWords
              .rebuild(
                (pb) => pb.remove(word),
              )
              .map((p0) => p0.id)
              .toBuiltList(),
        );
      };
    } else {
      return null;
    }
  }
}
