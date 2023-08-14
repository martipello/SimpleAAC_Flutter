import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'multi_image.dart';
import 'multi_image_id_builder.dart';
import 'simple_aac_tile.dart';

typedef WordCallBack = void Function(Word word);

const kTileAspectRatio = 1 / 1.3;

class WordTile extends StatelessWidget {
  const WordTile({
    required this.word,
    this.key,
    this.heroTag,
    this.wordTapCallBack,
    this.wordLongPressCallBack,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.handle,
    this.fadeImageIn = true,
    this.canLongPress = true,
  })  : assert(closeButtonOnLongPress != null ? canLongPress : true),
        super(key: key);

  final Key? key;
  final Word word;
  final String? heroTag;

  final WordCallBack? wordTapCallBack;
  final WordCallBack? closeButtonOnTap;
  final WordCallBack? closeButtonOnLongPress;
  final WordCallBack? wordLongPressCallBack;
  final Widget? handle;

  final bool isSelected;
  final bool fadeImageIn;
  final bool canLongPress;

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      key: key,
      aspectRatio: kTileAspectRatio,
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
        longPressCallBack: canLongPress
            ? () {
                wordLongPressCallBack?.call(word);
                Navigator.of(context).pushNamed(
                  WordBaseDetailView.routeName,
                  arguments: WordBaseDetailViewArguments(
                    word: word,
                    heroTag: heroTag,
                  ),
                );
              }
            : null,
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
    return MultiImageIDBuilder(
      multiImageIDBuilder: (final imageIds) {
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
                  child: _buildMultiImage(imageIds),
                ),
              ),
              _buildSmallMargin(),
              _buildWordDisplayName(context),
            ],
          ),
        );
      },
      wordBase: word,
    );
  }

  Widget _buildMultiImage(
    final BuiltList<String> imageIds,
  ) {
    return MultiImage(
      key: ValueKey(word.hashCode),
      imageIds: imageIds,
      heroTag: heroTag,
      fadeIn: fadeImageIn,
    );
  }

  Widget _buildWordDisplayName(
    final BuildContext context,
  ) {
    return Text(
      word.word,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: SimpleAACText.body1Style.copyWith(
        color: context.themeColors.onBackground,
      ),
    );
  }

  Widget _buildSmallMargin() {
    return const SizedBox(
      height: 4,
    );
  }
}
