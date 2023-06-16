import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../api/models/extensions/word_extension.dart';
import '../../../api/models/word.dart';
import '../../../api/models/word_sub_type.dart';
import '../../../dependency_injection_container.dart';
import '../../../view_models/selected_words_view_model.dart';
import '../../../view_models/words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class WordSubTypeView extends StatefulWidget {
  const WordSubTypeView({
    super.key,
    required this.wordSubType,
  });

  final WordSubType wordSubType;

  @override
  State<WordSubTypeView> createState() => _WordSubTypeViewState();
}

class _WordSubTypeViewState extends State<WordSubTypeView> with AutomaticKeepAliveClientMixin {
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();
  final wordsViewModel = getIt.get<WordsViewModel>();

  @override
  void initState() {
    super.initState();
    wordsViewModel.init(widget.wordSubType);
  }

  @override
  void dispose() {
    wordsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<BuiltList<Word>>(
      stream: wordsViewModel.wordsOfType,
      builder: (context, snapshot) {
        final words = snapshot.data ?? BuiltList();
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.count(
            crossAxisCount: 4,
            // calculate screen width
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.86,
            children: words
                .map(
                  (word) => WordTile(
                    word: word,
                    key: ValueKey(word.wordId),
                    heroTag: word.getHeroTag(
                      '${word.type}-${word.subType}-${word.wordId}',
                    ),
                    wordTapCallBack: selectedWordsViewModel.addSelectedWord,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
