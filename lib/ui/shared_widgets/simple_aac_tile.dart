import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import 'overlay_button.dart';

class SimpleAACTile extends StatelessWidget {
  SimpleAACTile({
    required this.child,
    final Key? key,
    this.border,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.handle,
    this.tapCallBack,
    this.longPressCallBack,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final VoidCallback? closeButtonOnTap;
  final VoidCallback? closeButtonOnLongPress;
  final VoidCallback? tapCallBack;
  final VoidCallback? longPressCallBack;
  final Widget? handle;

  final RoundedRectangleBorder? border;

  @override
  Widget build(final BuildContext context) {
    return Card(
      key: key,
      elevation: isSelected ? 0 : 2,
      color: isSelected ? context.themeColors.surfaceVariant : null,
      shape: border ?? defaultBorder,
      clipBehavior: Clip.hardEdge,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: tapCallBack,
          onLongPress: longPressCallBack,
          child: Stack(
            children: [
              child,
              if (closeButtonOnTap != null)
                buildCloseButton(
                  closeButtonOnLongPress,
                ),
              _buildHandle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() {

    return Positioned.fill(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: handle ?? SizedBox(),
        ),
      ),
    );
  }

  Widget buildCloseButton(
    final VoidCallback? closeButtonOnLongPress,
  ) {
    return _buildTileOverlayButton(
      alignment: Alignment.topRight,
      iconData: Icons.close,
      onTap: closeButtonOnTap,
      onLongPress: closeButtonOnLongPress,
    );
  }

  Widget _buildTileOverlayButton({
    required final Alignment alignment,
    required final IconData iconData,
    final VoidCallback? onTap,
    final VoidCallback? onLongPress,
  }) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(4),
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
