import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/iterable_extension.dart';
import '../../services/shared_preferences_service.dart';
import '../shared_widgets/chip_group.dart';
import '../shared_widgets/simple_aac_chip.dart';

typedef WordListCallBack = void Function(BuiltList<Word> word);

class PredictionsWidget extends StatelessWidget {
  PredictionsWidget({
    Key? key,
    required this.predictions,
    this.onPredictionsChanged,
    this.isExpanded = false,
  }) : super(key: key);

  final BuiltList<Word> predictions;
  final WordListCallBack? onPredictionsChanged;
  final bool isExpanded;

  final sharedPreferences = getIt.get<SharedPreferencesService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: sharedPreferences.hasPredictionsEnabled(),
      builder: (context, initialStateSnapshot) {
        return StreamBuilder<bool?>(
          initialData: initialStateSnapshot.data,
          stream: sharedPreferences.hasPredictionsEnabledStream,
          builder: (context, snapshot) {
            final hasPredictionsEnabled = snapshot.data ?? initialStateSnapshot.data ?? true;
            if (hasPredictionsEnabled) {
              return isExpanded ? _buildExpandedChipGroup() : _buildPredictionListView();
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }

  Widget _buildPredictionListView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 4,
        right: 96,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: predictions.length,
      itemBuilder: (context, index) {
        final word = predictions[index];
        return _buildPredictionChip(
          word,
          _getAddPredictionFunction(word),
          _getRemovePredictionFunction(word),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }

  VoidCallback? _getAddPredictionFunction(
    Word word,
  ) {
    if (onPredictionsChanged != null) {
      return () {
        onPredictionsChanged?.call(
          predictions.rebuild(
            (pb) => pb.add(word),
          ),
        );
      };
    } else {
      return null;
    }
  }

  VoidCallback? _getRemovePredictionFunction(
    Word word,
  ) {
    if (onPredictionsChanged != null) {
      return () {
        onPredictionsChanged?.call(
          predictions.rebuild(
            (pb) => pb.remove(word),
          ),
        );
      };
    } else {
      return null;
    }
  }

  Widget _buildExpandedChipGroup() {
    return ChipGroup(
      chips: predictions
          .map(
            (word) => _buildPredictionChip(
              word,
              _getAddPredictionFunction(word),
              _getRemovePredictionFunction(word),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPredictionChip(
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
