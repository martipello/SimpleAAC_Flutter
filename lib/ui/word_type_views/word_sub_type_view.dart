import 'package:flutter/material.dart';

import '../../../api/models/extensions/word_extension.dart';
import '../../../api/models/word.dart';
import '../../../api/models/word_sub_type.dart';
import '../../../dependency_injection_container.dart';
import '../../../view_models/selected_words_view_model.dart';
import '../../../view_models/words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class WordSubTypeView extends StatefulWidget {
  const WordSubTypeView({super.key, required this.wordSubType, this.wordTapCallBack, this.selectedWordIds});

  final WordSubType wordSubType;
  final WordCallBack? wordTapCallBack;
  final Set<String>? selectedWordIds;

  @override
  State<WordSubTypeView> createState() => _WordSubTypeViewState();
}

class _WordSubTypeViewState extends State<WordSubTypeView>
    with AutomaticKeepAliveClientMixin {
  final _selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();
  final _wordsViewModel = getIt.get<WordsViewModel>();
  final _scrollController = ScrollController();
  int _previousWordCount = 0;

  @override
  void initState() {
    super.initState();
    _wordsViewModel.init(widget.wordSubType);
  }

  @override
  void didUpdateWidget(WordSubTypeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.wordSubType != widget.wordSubType) {
      _previousWordCount = 0;
      _wordsViewModel.reinit(widget.wordSubType);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _wordsViewModel.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Word>>(
      stream: _wordsViewModel.sortedWordsOfType,
      builder: (context, snapshot) {
        final words = snapshot.data ?? [];
        if (words.length > _previousWordCount && _previousWordCount > 0) {
          _scrollToEnd();
        }
        _previousWordCount = words.length;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.count(
            controller: _scrollController,
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.86,
            children: words
                .map(
                  (word) => WordTile(
                    word: word,
                    key: ValueKey(word.wordId),
                    heroTag: word.getHeroTag(
                      '${word.type.name}-${word.subType.name}-${word.wordId}',
                    ),
                    isSelected: widget.selectedWordIds?.contains(word.wordId) ?? false,
                    wordTapCallBack: widget.wordTapCallBack ?? _selectedWordsViewModel.addSelectedWord,
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
