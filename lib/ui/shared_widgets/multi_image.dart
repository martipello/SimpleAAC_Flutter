import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import 'simple_aac_loading_widget.dart';
import 'view_model/multi_image_view_model.dart';
import '../theme/simple_aac_text.dart';

class MultiImage extends StatefulWidget {
  const MultiImage({
    required this.imageIds,
    final Key? key,
    this.heroTag,
    this.fadeIn = true,
    this.spacing = 4.0,
  }) : super(key: key);

  final BuiltList<String> imageIds;
  //Nullable because it's not always needed
  final String? heroTag;
  final bool fadeIn;
  final double spacing;

  @override
  State<MultiImage> createState() => _MultiImageState();
}

class _MultiImageState extends State<MultiImage> with SingleTickerProviderStateMixin {
  late AnimationController? _controller;
  final multiImageViewModel = getIt.get<MultiImageViewModel>();

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    multiImageViewModel.fourImages.listen(
      (final event) {
        final controller = _controller;
        if (event.isNotEmpty && widget.fadeIn && controller != null) {
          controller.forward();
        }
      },
    );
    multiImageViewModel.requestFourImages(widget.imageIds);
  }

  @override
  void didUpdateWidget(covariant final MultiImage oldWidget) {
    if (oldWidget.imageIds != widget.imageIds) {
      multiImageViewModel.requestFourImages(widget.imageIds);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    //TODO the below needs to be uncommented
    // multiImageViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return widget.heroTag != null
        ? wrapWithHero(
            _buildImageLoader(context),
            widget.heroTag!,
          )
        : _buildImageLoader(context);
  }

  Widget _buildImageLoader(final BuildContext context) {
    return StreamBuilder<Iterable<ImageInfo?>>(
      stream: multiImageViewModel.fourImages,
      builder: (final context, final snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final imageInfoList = BuiltList.of(snapshot.data ?? <ImageInfo>[]);
        return Stack(
          fit: StackFit.expand,
          children: [
            _buildImageHolder(imageInfoList),
            if (isLoading) SimpleAACLoadingWidget.shimmer(),
          ],
        );
      },
    );
  }

  Widget _buildImageHolder(
    final BuiltList<ImageInfo?> imageInfoList,
  ) {
    final imageContent = imageInfoList.whereType<ImageInfo>().toBuiltList();
    switch (imageContent.length) {
      case 0:
        return _buildEmptyImages();
      case 1:
        return _buildOneImage(imageContent.first);
      case 2:
        return _buildTwoImages(imageContent);
      case 3:
        return _buildThreeImages(imageContent);
      default:
        return _buildFourOrMoreImages(imageContent);
    }
  }

  Widget _buildOneImage(final ImageInfo imageInfo) {
    return _buildImageMaybeFadeInWrapper(
      imageInfo,
    );
  }

  Widget _buildTwoImages(
    final BuiltList<ImageInfo> imageInfoList,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _buildImageMaybeFadeInWrapper(
            imageInfoList.first,
          ),
        ),
        _buildSmallMargin,
        Expanded(
          child: _buildImageMaybeFadeInWrapper(
            imageInfoList[1],
          ),
        ),
      ],
    );
  }

  Widget _buildThreeImages(
    final BuiltList<ImageInfo> imageInfoList,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildImageMaybeFadeInWrapper(
                  imageInfoList.first,
                ),
              ),
              _buildSmallMargin,
              Expanded(
                child: _buildImageMaybeFadeInWrapper(
                  imageInfoList[1],
                ),
              ),
            ],
          ),
        ),
        _buildSmallMargin,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildImageMaybeFadeInWrapper(
                  imageInfoList[2],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFourOrMoreImages(
    final BuiltList<ImageInfo> imageInfoList,
  ) {
    final isMoreThanFour = widget.imageIds.length > 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildImageMaybeFadeInWrapper(
                  imageInfoList.first,
                ),
              ),
              _buildSmallMargin,
              Expanded(
                child: _buildImageMaybeFadeInWrapper(
                  imageInfoList[1],
                ),
              ),
            ],
          ),
        ),
        _buildSmallMargin,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _buildImageMaybeFadeInWrapper(
                  imageInfoList[2],
                ),
              ),
              _buildSmallMargin,
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImageMaybeFadeInWrapper(
                      imageInfoList[3],
                    ),
                    if (isMoreThanFour)
                      Positioned.fill(
                        child: ColoredBox(
                          color: context.themeColors.background.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              '+${widget.imageIds.length - 4}',
                              style: SimpleAACText.subtitle1Style.copyWith(
                                color: context.themeColors.onBackground.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget wrapWithHero(
    final Widget child,
    final String heroTag,
  ) {
    return Hero(
      tag: heroTag,
      transitionOnUserGestures: true,
      child: child,
    );
  }

  Widget _buildImageMaybeFadeInWrapper(
    final ImageInfo imageInfo,
  ) {
    final controller = _controller;
    if (widget.fadeIn && controller != null) {
      return FadeTransition(
        opacity: controller,
        child: _buildImage(
          imageInfo,
        ),
      );
    } else {
      return _buildImage(
        imageInfo,
      );
    }
  }

  Widget _buildImage(
    final ImageInfo imageInfo,
  ) {
    return RawImage(
      image: imageInfo.image,
      fit: BoxFit.cover,
    );
  }

  Widget _buildEmptyImages() {
    return const Center(
      child: Icon(
        Icons.error_outline_outlined,
      ),
    );
  }

  Widget get _buildSmallMargin => SizedBox(width: widget.spacing, height: widget.spacing);

// @override
// void didUpdateWidget(covariant MultiImage oldWidget) {
//   super.didUpdateWidget(oldWidget);
//   final imagesChanged = !listEquals(oldWidget.images.toList(), widget.images.toList());
//   if (imagesChanged) {
//     multiImageViewModel.requestFourImages(widget.images);
//   }
// }
}
