import 'package:flutter/material.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'simple_aac_tile.dart';
import 'word_image.dart';

typedef WordCallBack = void Function(Word word);

class WordTile extends StatelessWidget {
  const WordTile({
    required this.word,
    required this.key,
    this.heroTag,
    this.wordTapCallBack,
    this.hasReOrderButton = false,
    this.reorderIndex,
    this.isSelected = false,
    this.isHighlighted = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
  });

  final Word word;
  final Key key;
  final String? heroTag;

  final WordCallBack? wordTapCallBack;
  final WordCallBack? closeButtonOnTap;
  final WordCallBack? closeButtonOnLongPress;

  final bool hasReOrderButton;
  final int? reorderIndex;
  final bool isSelected;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: SimpleAACTile(
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
        isHighlighted: isHighlighted,
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
        reorderIndex: reorderIndex,
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
            child: heroTag != null
                ? Hero(
                    tag: heroTag!,
                    transitionOnUserGestures: true,
                    placeholderBuilder: (_, __, child) => child,
                    child: _buildClippedImage(),
                  )
                : _buildClippedImage(),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            word.text,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: SimpleAACText.body1Style.copyWith(
              color: context.themeColors.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClippedImage() => ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        clipBehavior: Clip.hardEdge,
        child: _buildImage(),
      );

  Widget _buildImage() => WordImage(
        imagePath: word.imagePaths.firstOrNull(),
        fit: BoxFit.cover,
      );
}
