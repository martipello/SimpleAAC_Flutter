import 'package:flutter/material.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'simple_aac_tile.dart';

typedef WordCallBack = void Function(Word word);

class WordTile extends StatelessWidget {
  const WordTile({
    required this.word,
    required this.key,
    required this.heroTag,
    this.wordTapCallBack,
    this.hasReOrderButton = false,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
  });

  final Word word;
  final Key key;
  final String heroTag;

  final WordCallBack? wordTapCallBack;
  final WordCallBack? closeButtonOnTap;
  final WordCallBack? closeButtonOnLongPress;

  final bool hasReOrderButton;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: SimpleAACTile(
        key: key,
        tapCallBack: () {
          wordTapCallBack?.call(word);
        },
        longTapCallBack: () {
          Navigator.of(context).pushNamed(
            WordDetailView.routeName,
            arguments: WordDetailViewArguments(
              word: word,
              heroTag: heroTag,
            ),
          );
        },
        border: RoundedRectangleBorder(
          side: BorderSide(
            color: word.type.getColor(context),
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
        child: _buildWordTileContent(context),
      ),
    );
  }

  Widget _buildWordTileContent(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              clipBehavior: Clip.hardEdge,
              child: Hero(
                tag: heroTag,
                child: Image.network(
                  word.imageList.firstOrNull() ?? 'assets/images/simple_aac_white_background.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            word.word,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: SimpleAACText.body1Style.copyWith(
              color: context.themeColors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
