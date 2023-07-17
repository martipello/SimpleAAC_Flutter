import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/api/models/sentence.dart';
import 'package:simple_aac/api/models/word.dart';
import 'package:simple_aac/api/models/word_group.dart';
import 'package:simple_aac/ui/shared_widgets/sentence_tile.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_tile.dart';
import 'package:simple_aac/ui/shared_widgets/view_constraint.dart';
import 'package:simple_aac/ui/shared_widgets/word_tile.dart';

import '../../api/models/word_base.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

class WordGroupTileExpanded extends StatelessWidget {
  const WordGroupTileExpanded({
    Key? key,
    required this.onClose,
    required this.isExpanded,
    this.selectedWordGroup,
  }) : super(key: key);

  final WordGroup? selectedWordGroup;
  final bool isExpanded;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final selectedWordGroup = this.selectedWordGroup;
    if (isExpanded && selectedWordGroup != null)
      return _buildWordGroupExpandedContent(
        context,
        selectedWordGroup,
      );
    return SizedBox();
  }

  Widget _buildWordGroupExpandedContent(
    BuildContext context,
    WordGroup wordGroup,
  ) {
    return ViewConstraint(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SimpleAACTile(
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
        ),
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
              onPressed: onClose,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWords(BuiltList<WordBase> words) {
    return Expanded(
      child: GridView.builder(
        itemCount: words.length,
        padding: const EdgeInsets.all(6),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 0.86,
        ),
        itemBuilder: (context, index) {
          final word = words[index];
          if (word is Word) {
            return WordTile(word: word);
          } else if (word is Sentence) {
            return SentenceTile(sentence: word);
          }
          throw Exception('Unknown word type');
        },
      ),
    );
  }
}
