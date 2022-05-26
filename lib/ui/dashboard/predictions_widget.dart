import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../services/shared_preferences_service.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/simple_aac_chip.dart';
import '../shared_widgets/word_tile.dart';

class PredictionsWidget extends StatelessWidget {
  PredictionsWidget({
    Key? key,
    this.word,
    this.onDelete,
    this.onSelected,
  }) : super(key: key);

  final Word? word;
  final WordTileTapCallBack? onDelete;
  final OnSelected? onSelected;

  final sharedPreferences = getIt.get<SharedPreferencesService>();
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: sharedPreferences.hasPredictionsEnabled(),
      builder: (context, initialStateSnapshot) {
        return StreamBuilder<bool?>(
          initialData: initialStateSnapshot.data,
          stream: sharedPreferences.hasPredictionsEnabledStream,
          builder: (context, snapshot) {
            final predictions = word?.predictionList.toList() ?? [];
            final chips = _buildPredictionChips(predictions);
            final _hasPredictionsEnabled = snapshot.data ?? initialStateSnapshot.data ?? true;
            return _hasPredictionsEnabled ? _buildPredictionListView(chips) : const SizedBox();
          },
        );
      },
    );
  }

  Widget _buildPredictionListView(
    List<Widget> chips,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: 4,
        right: 56,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: chips.length,
      itemBuilder: (context, index) {
        return chips[index];
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 12,
        );
      },
    );
  }

  List<Widget> _buildPredictionChips(
    List<Word?> predictions,
  ) {
    return predictions
        .whereType<Word>()
        .where((element) => element.word != null)
        .map(
          (e) => _buildPredictionChip(
            e.word ?? '',
            () {
              onDelete?.call(e);
            },
            onSelected,
          ),
        )
        .toList();
  }

  Widget _buildPredictionChip(
    String label,
    VoidCallback onDelete,
    OnSelected? onSelected,
  ) {
    return SimpleAACChip(
      label: label,
      isSelected: true,
      chipType: ChipType.normal,
      onDelete: onDelete,
      onSelected: onSelected,
    );
  }
}
