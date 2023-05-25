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
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        360,
      ),
      child: Container(
        color: Colors.white.withOpacity(
          0.7,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: SizedBox(
              height: size?.height ?? 24,
              width: size?.width ?? 24,
              child: Center(
                child: Icon(
                  iconData,
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
