import 'package:flutter/material.dart';
import '../../api/models/extensions/word_base_extension.dart';
import 'multi_image.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'simple_aac_tile.dart';

typedef WordCallBack = void Function(Word word);

class WordTile extends StatelessWidget {
  const WordTile({
    required this.word,
    this.key,
    this.heroTag,
    this.wordTapCallBack,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.handle,
    this.fadeImageIn = true,
  }) : super(key: key);

  final Key? key;
  final Word word;
  final String? heroTag;

  final WordCallBack? wordTapCallBack;
  final WordCallBack? closeButtonOnTap;
  final WordCallBack? closeButtonOnLongPress;
  final Widget? handle;

  final bool isSelected;
  final bool fadeImageIn;

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      key: key,
      aspectRatio: 1 / 1.3,
      child: SimpleAACTile(
        key: key,
        border: RoundedRectangleBorder(
          side: BorderSide(
            color: word.type.getColor(context),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        isSelected: isSelected,
        tapCallBack: () {
          print(word.hashCode);
          wordTapCallBack?.call(word);
        },
        longTapCallBack: () {
          Navigator.of(context).pushNamed(
            WordBaseDetailView.routeName,
            arguments: WordBaseDetailViewArguments(
              word: word,
              heroTag: heroTag,
            ),
          );
        },
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
        handle: handle,
        child: _buildWordTileContent(context),
      ),
    );
  }

  Widget _buildWordTileContent(
    final BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              clipBehavior: Clip.hardEdge,
              child: MultiImage(
                key: ValueKey(word.hashCode),
                images: word.getImageList(),
                heroTag: heroTag,
                fadeIn: fadeImageIn,
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
              color: context.themeColors.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
