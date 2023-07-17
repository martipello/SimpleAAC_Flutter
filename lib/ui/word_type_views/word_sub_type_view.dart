import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_aac/api/models/sentence.dart';
import 'package:simple_aac/api/models/word_base.dart';
import 'package:simple_aac/ui/shared_widgets/sentence_tile.dart';

import '../../../api/models/extensions/word_base_extension.dart';
import '../../../api/models/word.dart';
import '../../../api/models/word_sub_type.dart';
import '../../../dependency_injection_container.dart';
import '../../../view_models/selected_words_view_model.dart';
import '../../../view_models/words_view_model.dart';
import '../../api/models/word_group.dart';
import '../shared_widgets/word_group_tile.dart';
import '../shared_widgets/word_tile.dart';

class WordSubTypeView extends StatefulWidget {
  const WordSubTypeView({
    super.key,
    required this.wordSubType,
    required this.wordGroupTapCallBack,
  });

  final WordSubType wordSubType;
  final WordGroupCallBack wordGroupTapCallBack;

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
    return StreamBuilder<BuiltList<WordBase>>(
      stream: wordsViewModel.wordsOfType,
      builder: (context, snapshot) {
        final words = snapshot.data ?? BuiltList();
        return Stack(
          children: [
            GridView.builder(
              itemCount: words.length,
              padding: const EdgeInsets.all(6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 0.86,
              ),
              itemBuilder: (context, index) {
                final wordBase = words[index];
                if (wordBase is Word) {
                  return _buildWordTile(wordBase);
                } else if (wordBase is Sentence) {
                  return _buildSentenceTile(wordBase);
                } else if (wordBase is WordGroup) {
                  return _buildWordGroup(wordBase);
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildWordTile(Word word) {
    return WordTile(
      word: word,
      key: ValueKey(word.id),
      heroTag: word.getHeroTag(
        '${word.type}-${word.subType}-${word.id}',
      ),
      wordTapCallBack: selectedWordsViewModel.addSelectedWord,
    );
  }

  Widget _buildSentenceTile(Sentence word) {
    return SentenceTile(
      sentence: word,
      key: ValueKey(word.id),
      heroTag: word.getHeroTag(
        '${word.type}-${word.subType}-${word.id}',
      ),
      sentenceTapCallBack: selectedWordsViewModel.addSelectedWord,
    );
  }

  Widget _buildWordGroup(WordGroup word) {
    return WordGroupTile(
      word: word,
      key: ValueKey(word.id),
      onWordGroupTap: widget.wordGroupTapCallBack,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
