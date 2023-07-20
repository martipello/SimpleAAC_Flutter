import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import '../shared_widgets/sentence_tile.dart';
import '../shared_widgets/simple_aac_tile_handle.dart';
import '../theme/simple_aac_text.dart';

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
      (final _) {
        _addSelectedFilterListener();
      },
    );
  }

  bool onReorderComplete(
    final int index,
    final int dropIndex,
    final Object? slot,
  ) {
    if (index == dropIndex) {
      return false;
    }
    setState(() {
      isReordering = false;
    });
    selectedWordsViewModel.updatePositionSelectedWordList(
      index,
      dropIndex,
    );
    scrollController.jumpTo(scrollController.offset);
    return true;
  }

  void _addSelectedFilterListener() {
    const duration = Duration(milliseconds: 200);
    selectedWordsViewModel.selectedWords.listen(
      (final selectedTypes) {
        Future.delayed(duration).then(
          (final value) {
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
  Widget build(final BuildContext context) {
    return StreamBuilder<BuiltList<WordBase>>(
      stream: selectedWordsViewModel.selectedWords,
      builder: (final context, final snapshot) {
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

  Widget _buildGreatList(final BuiltList<WordBase> wordList) {
    return AutomaticAnimatedListView<WordBase>(
      list: wordList.toList(),
      comparator: AnimatedListDiffListComparator<WordBase>(
        sameItem: (final a, final b) => a.id == b.id,
        sameContent: (final a, final b) => a.id == b.id,
      ),
      itemBuilder: (final context, final wordBase, final data) {
        final index = wordList.indexOf(wordBase);
        if (index == -1 || data.measuring == true) {
          return const SizedBox();
        }
        if (wordBase is Word) {
          return _buildWordTile(wordBase, index);
        } else if (wordBase is Sentence) {
          return _buildSentenceTile(wordBase, index);
        } else {
          throw Exception('Unknown word type');
        }
      },
      reorderModel: AnimatedListReorderModel(
        onReorderComplete: onReorderComplete,
        onReorderStart: (final _, final __, final ___) {
          setState(() {
            isReordering = true;
          });
          return true;
        },
        onReorderMove: (final _, final __) => true,
      ),
      animator: DefaultAnimatedListAnimator(
        dismissIncomingDuration: const Duration(milliseconds: 150),
        reorderDuration: const Duration(milliseconds: 200),
        resizeDuration: const Duration(milliseconds: 200),
        movingDuration: const Duration(milliseconds: 200),
        movingCurve: Curves.easeInOut,
        resizeCurve: Curves.easeInOut,
        reorderCurve: Curves.easeInOut,
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 64, 8),
      scrollDirection: Axis.horizontal,
      listController: animatedListController,
      scrollController: scrollController,
      detectMoves: true,
      addFadeTransition: false,
    );
  }

  //TODO think this was working now isnt
  //TODO think how to fix hero flash animation

  Widget _buildWordTile(
    final Word word,
    final int index,
  ) {
    return WordTile(
      word: word,
      heroTag: word.getHeroTag('sentence-$index-'),
      closeButtonOnTap: selectedWordsViewModel.removeSelectedWord,
      closeButtonOnLongPress: (final _) {
        selectedWordsViewModel.clearSelectedWordList();
      },
      handle: SimpleAACTileHandle(
        controller: animatedListController,
      ),
      fadeImageIn: false,
    );
  }

  Widget _buildSentenceTile(
    final Sentence sentence,
    final int index,
  ) {
    return SentenceTile(
      sentence: sentence,
      heroTag: sentence.getHeroTag('sentence-$index-'),
      closeButtonOnTap: selectedWordsViewModel.removeSelectedWord,
      closeButtonOnLongPress: (final _) {
        selectedWordsViewModel.clearSelectedWordList();
      },
      handle: SimpleAACTileHandle(
        controller: animatedListController,
      ),
      fadeImageIn: false,
    );
  }
}
