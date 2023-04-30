import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../dependency_injection_container.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class FavouritesView extends StatelessWidget {
  //TODO create a view model that returns the list of cards
  //TODO based on the users keystage and takes in the search query
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.count(
        crossAxisCount: 4,
        // calculate screen width
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.86,
        children: _buildWordList()
            .map(
              (word) => WordTile(
                word: word,
                key: ValueKey(word.wordId),
                wordTapCallBack: selectedWordsViewModel.addSelectedWord,
              ),
            )
            .toList(),
      ),
    );
  }

  BuiltList<Word> _buildWordList() {
    return BuiltList([
      _buildWord('12423423', true),
      _buildWord('12523424', true),
      _buildWord('12623425', true),
      _buildWord('12723426', true),
      _buildWord('12823427', true),
      _buildWord('12923428', true),
    ]);
  }

  Word _buildWord(String id, bool addPredictions) {
    return Word((b) => b
      ..wordId = id
      ..word = 'hello ${id.substring(0, 3)}'
      ..imageList = ['assets/images/simple_aac.png'].toBuiltList().toBuilder()
      ..subType = WordSubType.abverb
      ..usageCount = 5
      ..type = WordType.quicks
      ..isUserAdded = false
      ..isFavourite = true
      ..sound = 'hello '
      ..keyStage = 3
      ..createdDate = DateTime.now()
      ..predictionList = addPredictions
          ? BuiltList.of(<Word>[
              _buildWord('123', false),
            ]).toBuilder()
          : BuiltList.of(<Word>[]).toBuilder());
  }
}
