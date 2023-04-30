import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../api/models/extensions/word_extension.dart';
import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class SentenceWidget extends StatefulWidget {
  @override
  State<SentenceWidget> createState() => _SentenceWidgetState();
}

class _SentenceWidgetState extends State<SentenceWidget> {
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        _addSelectedFilterListener();
      },
    );
  }

  void _addSelectedFilterListener() {
    const duration = Duration(milliseconds: 200);
    selectedWordsViewModel.selectedWordsStream.listen(
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
    return StreamBuilder<BuiltList<Word>>(
      stream: selectedWordsViewModel.selectedWordsStream,
      builder: (context, snapshot) {
        final words = snapshot.data ?? BuiltList<Word>();
        return SizedBox(
          height: 150,
          child: words.isEmpty
              ? const Center(
                  child: Text(
                    'EMPTY SENTENCE',
                  ),
                )
              : _buildListView(words),
        );
      },
    );
  }

  Widget _buildListView(
    BuiltList<Word> words,
  ) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        proxyDecorator: _proxyDecorator,
        itemCount: words.length,
        onReorder: selectedWordsViewModel.updatePositionSelectedWordList,
        padding: const EdgeInsets.fromLTRB(8, 8, 64, 8),
        scrollController: scrollController,
        itemBuilder: (context, index) {
          return _buildWord(
            words[index],
            index,
          );
        },
      ),
    );
  }

  Widget _proxyDecorator(
    Widget child,
    int index,
    Animation<double> animation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animValue = Curves.easeInOut.transform(
          animation.value,
        );
        final elevation = lerpDouble(
          0,
          8,
          animValue,
        )!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(
            0.1,
          ),
          child: child,
        );
      },
      child: child,
    );
  }

  Widget _buildWord(
    Word word,
    int index,
  ) {
    return WordTile(
      key: ValueKey(index),
      word: word,
      heroTag: word.getHeroTag('sentence-'),
      closeButtonOnTap: selectedWordsViewModel.removeSelectedWord,
      closeButtonOnLongPress: (_) {
        selectedWordsViewModel.clearSelectedWordList();
      },
      hasReOrderButton: false,
    );
  }
}
