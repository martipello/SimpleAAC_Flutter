import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/dependency_injection_container.dart';
import 'package:simple_aac/extensions/build_context_extension.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_loading_widget.dart';
import 'package:simple_aac/ui/shared_widgets/view_model/multi_image_view_model.dart';
import 'package:simple_aac/ui/theme/simple_aac_text.dart';

class MultiImage extends StatefulWidget {
  const MultiImage({
    Key? key,
    required this.images,
    this.heroTag,
    this.fadeIn = true,
    this.spacing = 4.0,
  }) : super(key: key);

  final BuiltList<String> images;

  //Nullable because it's not always needed
  final String? heroTag;
  final bool fadeIn;
  final double spacing;

  @override
  State<MultiImage> createState() => _MultiImageState();
}

class _MultiImageState extends State<MultiImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final multiImageViewModel = getIt.get<MultiImageViewModel>();

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    multiImageViewModel.fourImages.listen(
      (event) {
        if (event.isNotEmpty && widget.fadeIn) {
          _controller.forward();
        }
      },
    );
    multiImageViewModel.requestFourImages(widget.images);
  }

  void _initAnimationController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    //TODO the below needs to be uncommented
    // _controller.dispose();
    // multiImageViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.heroTag != null
        ? wrapWithHero(
            _buildImageLoader(context),
            widget.heroTag!,
          )
        : _buildImageLoader(context);
  }

  Widget _buildImageLoader(BuildContext context) {
    return StreamBuilder<Iterable<ImageInfo?>>(
      stream: multiImageViewModel.fourImages,
      builder: (context, snapshot) {
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
    BuiltList<ImageInfo?> imageInfoList,
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

  Widget _buildOneImage(ImageInfo imageInfo) {
    return _buildImageMaybeFadeInWrapper(
      imageInfo,
    );
  }

  Widget _buildTwoImages(
    BuiltList<ImageInfo> imageInfoList,
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
    BuiltList<ImageInfo> imageInfoList,
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
    BuiltList<ImageInfo> imageInfoList,
  ) {
    final isMoreThanFour = widget.images.length > 4;

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
                        child: Container(
                          color: context.themeColors.background.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              '+${widget.images.length - 4}',
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
    Widget child,
    String heroTag,
  ) {
    return Hero(
      tag: heroTag,
      transitionOnUserGestures: true,
      child: child,
    );
  }

  Widget _buildImageMaybeFadeInWrapper(
    ImageInfo imageInfo,
  ) {
    if (widget.fadeIn) {
      return FadeTransition(
        opacity: _controller,
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
    ImageInfo imageInfo,
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
