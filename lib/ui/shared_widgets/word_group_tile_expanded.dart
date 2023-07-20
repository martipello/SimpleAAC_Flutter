import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/api/models/sentence.dart';
import 'package:simple_aac/api/models/word.dart';
import 'package:simple_aac/api/models/word_group.dart';
import 'package:simple_aac/ui/shared_widgets/overlay_state_mixin.dart';
import 'package:simple_aac/ui/shared_widgets/sentence_tile.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_tile.dart';
import 'package:simple_aac/ui/shared_widgets/word_tile.dart';

import '../../api/models/word_base.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

typedef WordBaseCallBack = void Function(WordBase wordBase);
typedef StringCallBack = void Function(String string);

class WordGroupTileExpanded extends StatefulWidget {
  const WordGroupTileExpanded({
    Key? key,
    required this.onClose,
    required this.onRemoveWord,
    required this.selectedWordGroup,
    required this.onWordTap,
    required this.onTitleChange,
  }) : super(key: key);

  final WordGroup selectedWordGroup;
  final VoidCallback onClose;
  final WordBaseCallBack onRemoveWord;
  final WordBaseCallBack onWordTap;
  final StringCallBack onTitleChange;

  @override
  State<WordGroupTileExpanded> createState() => _WordGroupTileExpandedState();
}

class _WordGroupTileExpandedState extends State<WordGroupTileExpanded> with OverlayStateMixin {
  Widget build(BuildContext context) {
    final selectedWordGroup = this.widget.selectedWordGroup;
      return _buildWordGroupExpandedContent(
        context,
        selectedWordGroup,
      );
  }

  Widget _buildWordGroupExpandedContent(
    BuildContext context,
    WordGroup wordGroup,
  ) {
    return SimpleAACTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(
            context,
            wordGroup.displayName,
          ),
          _buildWords(
            wordGroup.words,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String title,
  ) {
    return Container(
      color: context.themeColors.surfaceVariant,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Text(
              title,
              style: SimpleAACText.subtitle1Style,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: IconButton(
              splashRadius: 12,
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              icon: const Icon(
                Icons.close,
              ),
              onPressed: removeOverlay,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWords(BuiltList<WordBase> words) {
    return GridView.builder(
      itemCount: words.length,
      padding: const EdgeInsets.all(6),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) {
        final word = words[index];
        if (word is Word) {
          return WordTile(
            word: word,
            fadeImageIn: false,
            closeButtonOnTap: widget.onRemoveWord,
            wordTapCallBack: widget.onWordTap,
          );
        } else if (word is Sentence) {
          return SentenceTile(
            sentence: word,
            fadeImageIn: false,
            closeButtonOnTap: widget.onRemoveWord,
            sentenceTapCallBack: widget.onWordTap,
          );
        }
        throw Exception('Unknown word type');
      },
    );
  }
}
