import 'package:flutter/material.dart';

import '../../api/models/sentence.dart';
import '../../api/models/word.dart';
import '../../api/models/word_base.dart';
import '../../api/models/word_group.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import 'rounded_button.dart';
import 'sentence_tile.dart';
import 'simple_aac_tile.dart';
import 'word_group_tile_expanded_view_model.dart';
import 'word_tile.dart';

typedef WordBaseCallBack = void Function(WordBase wordBase);
typedef StringCallBack = void Function(String string);

class WordGroupTileExpanded extends StatefulWidget {
  WordGroupTileExpanded({
    required this.onClose,
    required this.selectedWordGroup,
    required this.onWordTap,
    final Key? key,
  }) : super(key: key);

  final WordGroup selectedWordGroup;
  final VoidCallback onClose;
  final WordBaseCallBack onWordTap;

  @override
  State<WordGroupTileExpanded> createState() => _WordGroupTileExpandedState();
}

class _WordGroupTileExpandedState extends State<WordGroupTileExpanded> {
  final textController = TextEditingController();
  final wordGroupViewModel = getIt.get<WordGroupTileExpandedViewModel>();

  @override
  void initState() {
    super.initState();
    wordGroupViewModel.setInitialWordGroup(widget.selectedWordGroup);
    textController.addListener(
      () {
        wordBaseCallbackWithNotifier(
          (final _) {
            wordGroupViewModel.updateTitle(textController.text);
          },
        );
      },
    );
  }

  void _notifyChange() {
    wordGroupViewModel.validateForWordGroupChanges();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  Widget build(final BuildContext context) {
    ;
    return StreamBuilder<WordGroup>(
      stream: wordGroupViewModel.changedWordGroup,
      builder: (final context, final snapshot) {
        final selectedWordGroup = snapshot.data ?? this.widget.selectedWordGroup;
        return _buildWordGroupExpandedContent(
          context,
          selectedWordGroup,
        );
      },
    );
  }

  Widget _buildWordGroupExpandedContent(
    final BuildContext context,
    final WordGroup wordGroup,
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
          Flexible(
            child: _buildWords(
              wordGroup,
            ),
          ),
          StreamBuilder<bool>(
            stream: wordGroupViewModel.hasWordGroupChanged,
            builder: (final context, final snapshot) {
              final hasWordGroupChanged = snapshot.data ?? false;
              if (hasWordGroupChanged)
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: _buildButtonBar(),
                );
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    final BuildContext context,
    final String title,
  ) {
    return Container(
      color: context.themeColors.surfaceVariant,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: _buildWordGroupTitleTextField(title),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: _buildCloseWordGroupButton(),
          )
        ],
      ),
    );
  }

  Widget _buildWordGroupTitleTextField(final String title) {
    return TextField(
      controller: textController,
      style: SimpleAACText.subtitle1Style,
      decoration: InputDecoration(
        hintText: title,
      ),
    );
  }

  Widget _buildCloseWordGroupButton() {
    return IconButton(
      splashRadius: 12,
      constraints: const BoxConstraints(
        minWidth: 12,
        minHeight: 12,
      ),
      icon: const Icon(
        Icons.close,
      ),
      onPressed: widget.onClose,
    );
  }

  Widget _buildWords(final WordGroup wordGroup) {
    return GridView.builder(
      itemCount: wordGroup.wordIds.length * 10,
      padding: const EdgeInsets.all(6),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (final context, final index) {
        final wordId = wordGroup.wordIds[index % 3];
        //TODO wordGroupViewModel.getWord should have words and sentences
        return FutureBuilder<WordBase?>(
          future: wordGroupViewModel.getWord(wordId),
          builder: (final context, final snapshot) {
            final word = snapshot.data;
            if (word == null) {
              return const SizedBox();
            }
            if (word is Word) {
              return _buildWordTile(word);
            } else if (word is Sentence) {
              return _buildSentenceTile(word);
            }
            throw Exception('Unknown word type');
          },
        );
      },
    );
  }

  Widget _buildWordTile(final Word word) {
    return WordTile(
      word: word,
      fadeImageIn: false,
      closeButtonOnTap: wordBaseCallbackWithNotifier((final _) {
        wordGroupViewModel.removeWord(word.id);
      }),
      wordTapCallBack: wordBaseCallbackWithNotifier(widget.onWordTap),
      wordLongPressCallBack: (final _) {
        widget.onClose();
      },
    );
  }

  Widget _buildSentenceTile(final Sentence word) {
    return SentenceTile(
      sentence: word,
      fadeImageIn: false,
      canLongPress: false,
      closeButtonOnTap: wordBaseCallbackWithNotifier((final _) {
        wordGroupViewModel.removeWord(word.id);
      }),
      sentenceTapCallBack: wordBaseCallbackWithNotifier(widget.onWordTap),
      sentenceLongPressCallBack: (final _) {
        widget.onClose();
      },
    );
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: _buildDiscardChangesButton(),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: _buildSaveButton(),
        ),
        SizedBox(
          width: 4,
        ),
      ],
    );
  }

  Widget _buildDiscardChangesButton() {
    return RoundedButton(
      tooltip: 'Discard changes',
      fillColor: context.themeColors.tertiaryContainer,
      onPressed: () {
        wordGroupViewModel.discardChanges();
      },
      label: 'Discard',
    );
  }

  Widget _buildSaveButton() {
    return RoundedButton(
      onPressed: () {
        wordGroupViewModel.saveChanges();
      },
      label: 'Save',
    );
  }

  WordBaseCallBack wordBaseCallbackWithNotifier(
    final WordBaseCallBack onWordTap,
  ) {
    return (final wordBase) {
      onWordTap.call(wordBase);
      _notifyChange();
    };
  }
}
