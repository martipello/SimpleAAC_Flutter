import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../extensions/iterable_extension.dart';
import '../theme/base_theme.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'simple_aac_tile.dart';

typedef WordTileTapCallBack = void Function(Word? word);

class WordTile extends StatelessWidget {
  const WordTile({
    required this.word,
    this.wordTapCallBack,
    this.hasReOrderButton = false,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.key,
  });

  final Key? key;
  final Word? word;
  final WordTileTapCallBack? wordTapCallBack;
  final WordTileTapCallBack? closeButtonOnTap;
  final WordTileTapCallBack? closeButtonOnLongPress;
  final bool hasReOrderButton;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SimpleAACTile(
      key: key,
      border: RoundedRectangleBorder(
        side: BorderSide(
          color: colors(context).primary,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      isSelected: isSelected,
      closeButtonOnTap: closeButtonOnTap != null
          ? () {
              closeButtonOnTap?.call(word);
            }
          : null,
      closeButtonOnLongPress: closeButtonOnLongPress != null
          ? () {
              closeButtonOnLongPress?.call(word);
            }
          : null,
      hasReOrderButton: hasReOrderButton,
      child: AspectRatio(
        aspectRatio: 1.0 / 1.3,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              wordTapCallBack?.call(word);
            },
            onLongPress: () {
              Navigator.of(context).pushNamed(
                WordDetailView.routeName,
                arguments: WordDetailViewArguments(
                  word: word,
                ),
              );
            },
            child: _buildWordTileContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildWordTileContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Hero(
              tag: word?.wordId ?? '',
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  word?.imageList.firstOrNull() ?? 'assets/images/sealstudioslogocenter.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            word?.word ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: SimpleAACText.body4Style,
          ),
        ],
      ),
    );
  }
}
