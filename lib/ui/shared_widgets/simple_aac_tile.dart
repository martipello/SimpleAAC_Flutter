import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import 'overlay_button.dart';

class SimpleAACTile extends StatelessWidget {
  SimpleAACTile({
    Key? key,
    this.border,
    required this.child,
    this.isSelected = false,
    this.isHighlighted = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.hasReOrderButton = false,
    this.reorderIndex,
    this.tapCallBack,
    this.longTapCallBack,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final bool isHighlighted;
  final VoidCallback? closeButtonOnTap;
  final VoidCallback? closeButtonOnLongPress;
  final VoidCallback? tapCallBack;
  final VoidCallback? longTapCallBack;
  final bool hasReOrderButton;
  final int? reorderIndex;
  final RoundedRectangleBorder? border;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      elevation: isSelected ? 0 : 2,
      color: isSelected ? context.themeColors.surfaceVariant : null,
      shape: isHighlighted
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: context.themeColors.primary.withOpacity(0.5),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
            )
          : (border ?? defaultBorder),
      clipBehavior: Clip.hardEdge,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: tapCallBack,
          onLongPress: longTapCallBack,
          child: Stack(
            children: [
              child,
              if (isHighlighted)
                Positioned.fill(
                  child: IgnorePointer(
                    child: ColoredBox(
                      color: context.themeColors.primary.withOpacity(0.08),
                    ),
                  ),
                ),
              if (isSelected)
                Positioned.fill(
                  child: IgnorePointer(
                    child: ColoredBox(
                      color: context.themeColors.primary.withOpacity(0.18),
                    ),
                  ),
                ),
              if (isSelected)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: IgnorePointer(
                      child: Icon(
                        Icons.check_circle,
                        color: context.themeColors.primary,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              if (closeButtonOnTap != null)
                buildCloseButton(
                  closeButtonOnLongPress,
                ),
              if (hasReOrderButton) buildReOrderButton(reorderIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCloseButton(
    VoidCallback? closeButtonOnLongPress,
  ) {
    return _buildTileOverlapButton(
      alignment: Alignment.topRight,
      iconData: Icons.close,
      onTap: closeButtonOnTap,
      onLongPress: closeButtonOnLongPress,
    );
  }

  Widget buildReOrderButton(int? index) {
    Widget button = OverlayButton(
      iconData: Icons.menu,
      onTap: null,
    );
    if (index != null) {
      button = ReorderableDragStartListener(
        index: index,
        child: button,
      );
    }
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: button,
        ),
      ),
    );
  }

  Widget _buildTileOverlapButton({
    required Alignment alignment,
    required IconData iconData,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: OverlayButton(
            iconData: iconData,
            onTap: onTap,
            onLongPress: onLongPress,
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder get defaultBorder => RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );

}
