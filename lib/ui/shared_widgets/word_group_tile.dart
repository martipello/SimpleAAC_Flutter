import 'package:flutter/material.dart';
import '../../api/models/extensions/word_base_extension.dart';
import '../../api/models/word_group.dart';
import 'multi_image.dart';
import 'overlay_state_mixin.dart';
import 'word_group_tile_expanded.dart';

import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

typedef WordGroupCallBack = void Function(WordGroup word);

class WordGroupTile extends StatefulWidget {
  const WordGroupTile({
    required this.onWordTap,
    required this.wordGroup,
    this.key,
    this.heroTag,
  }) : super(key: key);

  final Key? key;
  final WordGroup wordGroup;
  final String? heroTag;
  final WordBaseCallBack onWordTap;

  @override
  State<WordGroupTile> createState() => _WordGroupTileState();
}

class _WordGroupTileState extends State<WordGroupTile> with SingleTickerProviderStateMixin, OverlayStateMixin {

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      key: widget.key,
      aspectRatio: 1 / 1.3,
      child: _buildWordTileContent(context),
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
                      onTap: () {
                        toggleOverlay(
                          WordGroupTileExpanded(
                            selectedWordGroup: widget.wordGroup,
                            onClose: removeOverlay,
                            onRemoveWord: (final _) {},
                            onTitleChange: (final _) {
                              //TODO(MS): implement text controller with a listener that updates this widget on change
                            },
                            onWordTap: widget.onWordTap,
                          ),
                        );
                      },
                      child: MultiImage(
                        key: ValueKey(widget.wordGroup.hashCode),
                        images: widget.wordGroup.getImageList(),
                        heroTag: widget.heroTag,
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
            widget.wordGroup.displayName,
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
