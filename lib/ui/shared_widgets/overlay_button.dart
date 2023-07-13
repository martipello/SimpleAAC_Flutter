import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

class OverlayButton extends StatelessWidget {
  const OverlayButton({
    super.key,
    required this.iconData,
    this.onTap,
    this.onLongPress,
    this.size,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
  }) : assert(
          onTap != null ||
              onLongPress != null ||
              onVerticalDragStart != null ||
              onVerticalDragUpdate != null ||
              onVerticalDragEnd != null ||
              onVerticalDragCancel != null,
        );

  final IconData iconData;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragCancelCallback? onVerticalDragCancel;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final height = size?.height ?? 24;
    final width = size?.width ?? 24;
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
          color: context.themeColors.background.withOpacity(
            0.6,
          ),
        ),
        height: height,
        width: width,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {},
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              onLongPress: onLongPress,
              onVerticalDragStart: onVerticalDragStart,
              onVerticalDragUpdate: onVerticalDragUpdate,
              onVerticalDragEnd: onVerticalDragEnd,
              onVerticalDragCancel: onVerticalDragCancel,
              child: SizedBox(
                child: Center(
                  child: Icon(
                    iconData,
                    size: height * 0.75,
                    color: context.themeColors.onBackground,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
