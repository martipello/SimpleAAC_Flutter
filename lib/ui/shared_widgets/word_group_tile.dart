import 'package:flutter/material.dart';
import 'package:simple_aac/api/models/extensions/word_base_extension.dart';
import 'package:simple_aac/api/models/word_group.dart';
import 'package:simple_aac/ui/shared_widgets/multi_image.dart';

import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

typedef WordGroupCallBack = void Function(WordGroup word);

class WordGroupTile extends StatelessWidget {
  const WordGroupTile({
    this.key,
    required this.word,
    this.heroTag, this.onWordGroupTap,
  }) : super(key: key);

  final Key? key;
  final WordGroup word;
  final String? heroTag;
  final WordGroupCallBack? onWordGroupTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      key: key,
      aspectRatio: 1 / 1.3,
      child: _buildWordTileContent(context),
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
          _buildSmallMargin(),
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(360),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                        onWordGroupTap?.call(word);
                      },
                      child: MultiImage(
                        key: ValueKey(word.hashCode),
                        images: word.getImageList(),
                        heroTag: heroTag,
                        fadeIn: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildSmallMargin(),
          Text(
            word.displayName,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: SimpleAACText.body1Style.copyWith(
              color: context.themeColors.onBackground,
            ),
          ),
          _buildSmallMargin(),
        ],
      ),
    );
  }

  SizedBox _buildSmallMargin() {
    return const SizedBox(
          height: 4,
        );
  }
}
