import 'package:flutter/material.dart';
import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/sentence.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'multi_image.dart';
import 'simple_aac_tile.dart';

typedef SentenceCallBack = void Function(Sentence sentence);

class SentenceTile extends StatelessWidget {
  const SentenceTile({
    required this.sentence,
    this.key,
    this.heroTag,
    this.sentenceTapCallBack,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.handle,
    this.fadeImageIn = true,
  }) : super(key: key);

  final Key? key;
  final Sentence sentence;
  final String? heroTag;

  final SentenceCallBack? sentenceTapCallBack;
  final SentenceCallBack? closeButtonOnTap;
  final SentenceCallBack? closeButtonOnLongPress;

  final Widget? handle;
  final bool isSelected;
  final bool fadeImageIn;

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: SimpleAACTile(
        key: key,
        border: RoundedRectangleBorder(
          side: BorderSide(
            color: sentence.type.getColor(context),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        isSelected: isSelected,
        tapCallBack: () {
          sentenceTapCallBack?.call(sentence);
        },
        longTapCallBack: () {
          Navigator.of(context).pushNamed(
            WordBaseDetailView.routeName,
            arguments: WordBaseDetailViewArguments(
              word: sentence,
              heroTag: heroTag,
            ),
          );
        },
        closeButtonOnTap: closeButtonOnTap != null
            ? () {
                closeButtonOnTap?.call(sentence);
              }
            : null,
        closeButtonOnLongPress: closeButtonOnLongPress != null
            ? () {
                closeButtonOnLongPress?.call(sentence);
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
          Flexible(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
              clipBehavior: Clip.hardEdge,
              child: _buildImage(),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            sentence.words.map((final wb) => wb.word).join(' '),
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

  Widget _buildImage() {
    return MultiImage(
      key: ValueKey(sentence.hashCode),
      images: sentence.getImageList(),
      heroTag: heroTag,
      fadeIn: fadeImageIn,
    );
  }
}
