import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../api/models/word_group.dart';
import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import 'multi_image.dart';
import 'multi_image_id_builder.dart';
import 'overlay_state_mixin.dart';
import 'word_group_tile_expanded.dart';
import 'word_tile.dart';

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
      aspectRatio: kTileAspectRatio,
      child: _buildWordTileContent(),
    );
  }

  Widget _buildWordTileContent() {
    return MultiImageIDBuilder(
      multiImageIDBuilder: (final imageIds) {
        return Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSmallMargin(),
              Expanded(
                child: Center(
                  child: _buildCircleGroupHolder(
                    imageIds,
                  ),
                ),
              ),
              _buildSmallMargin(),
              _buildWordGroupDisplayName(),
              _buildSmallMargin(),
            ],
          ),
        );
      },
      wordBase: widget.wordGroup,
    );
  }

  Widget _buildCircleGroupHolder(
    final BuiltList<String> imageIds,
  ) {
    return AspectRatio(
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
                  onWordTap: widget.onWordTap,
                  selectedWordGroup: widget.wordGroup,
                  onClose: removeOverlay,
                ),
              );
            },
            child: _buildMultiImage(imageIds),
          ),
        ),
      ),
    );
  }

  Widget _buildMultiImage(
    final BuiltList<String> imageIds,
  ) {
    return MultiImage(
      key: ValueKey(widget.wordGroup.hashCode),
      imageIds: imageIds,
      heroTag: widget.heroTag,
      fadeIn: true,
    );
  }

  Widget _buildWordGroupDisplayName() {
    return Text(
      widget.wordGroup.displayName,
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
