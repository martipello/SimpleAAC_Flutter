import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../api/models/word_group.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../../services/image_path_service.dart';
import '../theme/simple_aac_text.dart';
import 'simple_aac_tile.dart';
import 'word_image.dart';

class WordGroupTile extends StatelessWidget {
  const WordGroupTile({
    super.key,
    required this.group,
    required this.words,
    this.onTap,
    this.onLongPress,
  });

  final WordGroup group;
  final List<Word> words;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: SimpleAACTile(
        tapCallBack: onTap,
        longTapCallBack: onLongPress,
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              clipBehavior: Clip.hardEdge,
              child: _buildMosaic(),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            group.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: SimpleAACText.body1Style.copyWith(
              color: context.themeColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMosaic() {
    final paths = words
        .take(4)
        .map((w) => getIt<ImagePathService>().resolve(w))
        .toList();

    if (paths.isEmpty) {
      return WordImage(imagePath: null);
    }
    if (paths.length == 1) {
      return WordImage(imagePath: paths[0]);
    }
    if (paths.length == 2) {
      return Row(
        children: [
          Expanded(child: WordImage(imagePath: paths[0])),
          const SizedBox(width: 1),
          Expanded(child: WordImage(imagePath: paths[1])),
        ],
      );
    }
    if (paths.length == 3) {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: WordImage(imagePath: paths[0])),
                const SizedBox(height: 1),
                Expanded(child: WordImage(imagePath: paths[1])),
              ],
            ),
          ),
          const SizedBox(width: 1),
          Expanded(child: WordImage(imagePath: paths[2])),
        ],
      );
    }
    // 4 images: 2×2 grid
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: WordImage(imagePath: paths[0])),
              const SizedBox(width: 1),
              Expanded(child: WordImage(imagePath: paths[1])),
            ],
          ),
        ),
        const SizedBox(height: 1),
        Expanded(
          child: Row(
            children: [
              Expanded(child: WordImage(imagePath: paths[2])),
              const SizedBox(width: 1),
              Expanded(child: WordImage(imagePath: paths[3])),
            ],
          ),
        ),
      ],
    );
  }
}
