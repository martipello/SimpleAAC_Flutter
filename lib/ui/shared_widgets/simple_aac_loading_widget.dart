import 'package:flutter/material.dart';
import 'package:flutter_animate/animate.dart';
import 'package:flutter_animate/effects/effects.dart';
import 'package:flutter_animate/extensions/extensions.dart';

import '../../extensions/build_context_extension.dart';

enum LoadingType {
  circularProgressIndicator,
  shimmer,
}

class SimpleAACLoadingWidget extends StatelessWidget {

  const SimpleAACLoadingWidget.circularProgressIndicator({
    final Color? valueColor,
    final double? width,
  }) : this._(
          valueColor: valueColor,
          width: width,
          loadingType: LoadingType.circularProgressIndicator,
        );

  const SimpleAACLoadingWidget.shimmer()
      : this._(
          valueColor: null,
          width: null,
          loadingType: LoadingType.shimmer,
        );
  const SimpleAACLoadingWidget._({
    required this.loadingType,
    final Key? key,
    this.valueColor,
    this.width,
  }) : super(key: key);

  final Color? valueColor;
  final double? width;
  final LoadingType loadingType;

  @override
  Widget build(final BuildContext context) {
    switch (loadingType) {
      case LoadingType.circularProgressIndicator:
        return _buildCircularProgressIndicator(context);
      case LoadingType.shimmer:
        return _buildShimmer(context);
    }
  }

  CircularProgressIndicator _buildCircularProgressIndicator(
    final BuildContext context,
  ) {
    return CircularProgressIndicator(
      strokeWidth: width ?? 4.0,
      valueColor: valueColor != null
          ? AlwaysStoppedAnimation(
              valueColor,
            )
          : AlwaysStoppedAnimation(
              context.themeColors.primary,
            ),
    );
  }

  Widget _buildShimmer(final BuildContext context) {
    return Container(
      color: context.themeColors.primaryContainer,
    )
        .animate(
          onPlay: (final controller) => controller.repeat(),
        )
        .shimmer(
          duration: 1300.ms,
          color: context.themeColors.onPrimaryContainer.withOpacity(0.1),
          blendMode: BlendMode.srcATop,
        );
  }
}
