import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:simple_aac/ui/shared_widgets/sentence_tile.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_tile_handle.dart';
import 'package:simple_aac/ui/theme/simple_aac_text.dart';

import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/sentence.dart';
import '../../api/models/word.dart';
import '../../api/models/word_base.dart';
import '../../dependency_injection_container.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/word_tile.dart';

typedef ReOrderCallBack = void Function(int oldIndex, int newIndex);
typedef WordBaseWithIndexCallBack = Widget Function(WordBase wordBase, int index);

class SentenceWidget extends StatefulWidget {
  @override
  State<SentenceWidget> createState() => _SentenceWidgetState();
}

class _SentenceWidgetState extends State<SentenceWidget> with SingleTickerProviderStateMixin {
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();
  final scrollController = ScrollController();
  final animatedListController = AnimatedListController();

  bool isReordering = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _addSelectedFilterListener();
      },
    );
  }

  void onReorderFinished(List<Word> newItems) {
    scrollController.jumpTo(scrollController.offset);
    setState(() {
      isReordering = false;
    });
  }

  void _addSelectedFilterListener() {
    const duration = Duration(milliseconds: 200);
    selectedWordsViewModel.selectedWords.listen(
      (selectedTypes) {
        Future.delayed(duration).then(
          (value) {
            if (scrollController.hasClients) {
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: duration,
                curve: Curves.fastOutSlowIn,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BuiltList<WordBase>>(
      stream: selectedWordsViewModel.selectedWords,
      builder: (context, snapshot) {
        final words = snapshot.data ?? BuiltList<Word>();
        return SizedBox(
          height: 150,
          child: words.isEmpty ? _buildEmptySentenceWidget() : _buildGreatList(words),
        );
      },
    );
  }

  Widget _buildEmptySentenceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Empty Sentence',
          style: SimpleAACText.subtitle2Style,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Lets start Simple',
          style: SimpleAACText.body4Style,
        ),
      ],
    );
  }

  Widget _buildGreatList(BuiltList<WordBase> wordList) {
    return AutomaticAnimatedListView<WordBase>(
      list: wordList.toList(),
      padding: const EdgeInsets.fromLTRB(8, 8, 64, 8),
      scrollDirection: Axis.horizontal,
      comparator: AnimatedListDiffListComparator<WordBase>(
        sameItem: (a, b) => a.id == b.id,
        sameContent: (a, b) => a.getImageList() == b.getImageList(),
      ),
      itemBuilder: (context, wordBase, data) {
        final index = wordList.indexOf(wordBase);
        if (wordBase is Word) {
          return _buildWordTile(wordBase, index);
        } else if (wordBase is Sentence) {
          return _buildSentenceTile(wordBase, index);
        } else {
          throw Exception('Unknown word type');
        }
      },
      listController: animatedListController,
      scrollController: scrollController,
      addLongPressReorderable: true,
      reorderModel: AutomaticAnimatedListReorderModel(
        wordList.toList(),
      ),
      detectMoves: true,
    );
  }

  Widget _buildWordTile(
    Word word,
    int index,
  ) {
    return WordTile(
      word: word,
      index: index,
      heroTag: word.getHeroTag('sentence-$index-'),
      closeButtonOnTap: selectedWordsViewModel.removeSelectedWord,
      closeButtonOnLongPress: (_) {
        selectedWordsViewModel.clearSelectedWordList();
      },
      handle: SimpleAACTileHandle(
        controller: animatedListController,
      ),
      fadeImageIn: false,
    );
  }

  Widget _buildSentenceTile(
    Sentence sentence,
    int index,
  ) {
    return SentenceTile(
      sentence: sentence,
      index: index,
      heroTag: sentence.getHeroTag('sentence-$index-'),
      closeButtonOnTap: selectedWordsViewModel.removeSelectedWord,
      closeButtonOnLongPress: (_) {
        selectedWordsViewModel.clearSelectedWordList();
      },
      handle: SimpleAACTileHandle(
        controller: animatedListController,
      ),
      fadeImageIn: false,
    );
  }
}
