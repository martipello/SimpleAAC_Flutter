import 'package:flutter/material.dart';
import 'package:simple_aac/api/models/sentence.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../theme/simple_aac_text.dart';
import 'simple_aac_tile.dart';

typedef SentenceCallBack = void Function(Sentence sentence);

class SentenceTile extends StatelessWidget {
  const SentenceTile({
    required this.sentence,
    required this.key,
    this.heroTag,
    this.sentenceTapCallBack,
    this.hasReOrderButton = false,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
  });

  final Sentence sentence;
  final Key key;
  final String? heroTag;

  final SentenceCallBack? sentenceTapCallBack;
  final SentenceCallBack? closeButtonOnTap;
  final SentenceCallBack? closeButtonOnLongPress;

  final bool hasReOrderButton;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: SimpleAACTile(
        key: key,
        tapCallBack: () {
          sentenceTapCallBack?.call(sentence);
        },
        longTapCallBack: () {
          // Navigator.of(context).pushNamed(
          //   WordDetailView.routeName,
          //   arguments: WordDetailViewArguments(
          //     word: word,
          //     heroTag: heroTag,
          //   ),
          // );
        },
        border: RoundedRectangleBorder(
          side: BorderSide(
            color: sentence.type.getColor(context),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        isSelected: isSelected,
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
              child: heroTag != null
                  ? wrapWithHero(
                      _buildImage(),
                      heroTag!,
                    )
                  : _buildImage(),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            sentence.words.join(''),
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

  Widget wrapWithHero(Widget child, String heroTag) {
    return Hero(
      tag: heroTag,
      child: child,
    );
  }

  Widget _buildImage() {
    return Image.network(
      sentence.words.first.imageList.firstOrNull() ?? 'assets/images/simple_aac_white_background.png',
      fit: BoxFit.cover,
    );
  }
}
