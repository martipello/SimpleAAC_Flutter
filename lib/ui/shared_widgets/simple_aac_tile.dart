import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import 'overlay_button.dart';

class SimpleAACTile extends StatelessWidget {
  SimpleAACTile({
    Key? key,
    this.border,
    required this.child,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.hasReOrderButton = false,
    this.tapCallBack,
    this.longTapCallBack,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final VoidCallback? closeButtonOnTap;
  final VoidCallback? closeButtonOnLongPress;
  final VoidCallback? tapCallBack;
  final VoidCallback? longTapCallBack;
  final bool hasReOrderButton;
  final RoundedRectangleBorder? border;

  @override
  Widget build(BuildContext context) {
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
          onLongPress: longTapCallBack,
          child: Stack(
            children: [
              child,
              if (closeButtonOnTap != null)
                buildCloseButton(
                  closeButtonOnLongPress,
                ),
              if (hasReOrderButton) buildReOrderButton(),
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

  Widget buildReOrderButton() {
    return _buildTileOverlapButton(
      alignment: Alignment.topLeft,
      iconData: Icons.menu,
      onTap: () {},
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
