import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/sentence.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import '../word_detail_view.dart';
import 'multi_image.dart';
import 'multi_image_id_builder.dart';
import 'simple_aac_tile.dart';
import 'word_tile.dart';

typedef SentenceCallBack = void Function(Sentence sentence);

class SentenceTile extends StatelessWidget {
  const SentenceTile({
    required this.sentence,
    this.sentenceTapCallBack,
    this.sentenceLongPressCallBack,
    this.key,
    this.heroTag,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.handle,
    this.fadeImageIn = true,
    this.canLongPress = true,
  }) : super(key: key);

  final Key? key;
  final Sentence sentence;
  final String? heroTag;

  final SentenceCallBack? sentenceTapCallBack;
  final SentenceCallBack? closeButtonOnTap;
  final SentenceCallBack? closeButtonOnLongPress;
  final SentenceCallBack? sentenceLongPressCallBack;

  final Widget? handle;
  final bool isSelected;
  final bool fadeImageIn;
  final bool canLongPress;

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      aspectRatio: kTileAspectRatio,
      child: SimpleAACTile(
        key: key,
        border: buildRoundedRectangleBorder(context),
        isSelected: isSelected,
        tapCallBack: _getTapCallback,
        longPressCallBack: canLongPress
            ? () {
                sentenceLongPressCallBack?.call(sentence);
                Navigator.of(context).pushNamed(
                  WordBaseDetailView.routeName,
                  arguments: WordBaseDetailViewArguments(
                    word: sentence,
                    heroTag: heroTag,
                  ),
                );
              }
            : null,
        closeButtonOnTap: _getCloseButtonOnTap,
        closeButtonOnLongPress: _getCloseButtonOnLongPress,
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
          _buildSentenceDisplayName(),
        ],
      ),
    );
  }

  Widget _buildSentenceDisplayName() {
    return FutureBuilder<BuiltList<String>>(
      future: sentence.getWords(),
      builder: (final context, final snapshot) {
        final words = snapshot.data ?? BuiltList<String>();
        return Text(
          words.join(' '),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: SimpleAACText.body1Style.copyWith(
            color: context.themeColors.onBackground,
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    return MultiImageIDBuilder(
      multiImageIDBuilder: (final imageIds){
        return MultiImage(
          key: ValueKey(sentence.hashCode),
          imageIds: imageIds,
          heroTag: heroTag,
          fadeIn: fadeImageIn,
        );
      },
      wordBase: sentence,
    );
  }

  VoidCallback? _getTapCallback() {
    final sentenceTapCallBack = this.sentenceTapCallBack;
    return sentenceTapCallBack != null
        ? () {
            sentenceTapCallBack.call(sentence);
          }
        : null;
  }

  VoidCallback? _getCloseButtonOnTap() {
    final closeButtonOnTap = this.closeButtonOnTap;
    return closeButtonOnTap != null
        ? () {
            closeButtonOnTap.call(sentence);
          }
        : null;
  }

  VoidCallback? _getCloseButtonOnLongPress() {
    final closeButtonOnLongPress = this.closeButtonOnLongPress;
    return closeButtonOnLongPress != null
        ? () {
            closeButtonOnLongPress.call(sentence);
          }
        : null;
  }

  RoundedRectangleBorder buildRoundedRectangleBorder(
    final BuildContext context,
  ) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: sentence.type.getColor(context),
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }
}
