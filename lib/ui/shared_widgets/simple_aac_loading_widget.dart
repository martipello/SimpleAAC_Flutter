import 'package:flutter/material.dart';

import '../theme/base_theme.dart';

class SimpleAACLoadingWidget extends StatelessWidget {
  const SimpleAACLoadingWidget({
    Key? key,
    this.valueColor,
    this.width,
  }) : super(key: key);

  final Color? valueColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: width ?? 4.0,
      valueColor: valueColor != null
          ? AlwaysStoppedAnimation(
              valueColor,
            )
          : AlwaysStoppedAnimation(
              colors(context).secondary,
            ),
    );
  }
}
