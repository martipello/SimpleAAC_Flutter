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
  const SimpleAACLoadingWidget._({
    Key? key,
    this.valueColor,
    this.width,
    required this.loadingType,
  }) : super(key: key);

  final Color? valueColor;
  final double? width;
  final LoadingType loadingType;

  const SimpleAACLoadingWidget.circularProgressIndicator({
    Color? valueColor,
    double? width,
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

  @override
  Widget build(BuildContext context) {
    switch (loadingType) {
      case LoadingType.circularProgressIndicator:
        return _buildCircularProgressIndicator(context);
      case LoadingType.shimmer:
        return _buildShimmer(context);
    }
  }

  CircularProgressIndicator _buildCircularProgressIndicator(
    BuildContext context,
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

  Widget _buildShimmer(BuildContext context) {
    return Container(
      color: context.themeColors.primaryContainer,
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: 1300.ms,
          color: context.themeColors.onPrimaryContainer.withOpacity(0.1),
          blendMode: BlendMode.srcATop,
        );
  }
}
