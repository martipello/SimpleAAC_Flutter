import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

class OverlayButton extends StatelessWidget {
  const OverlayButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.onLongPress,
    this.size,
  });

  final IconData iconData;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final height = size?.height ?? 24;
    final width = size?.width ?? 24;
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          color: context.themeColors.background.withOpacity(
            0.3,
          ),
        ),
        height: height,
        width: width,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: SizedBox(
              child: Center(
                child: Icon(
                  iconData,
                  size: height * 0.56,
                  color: context.themeColors.onBackground,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
