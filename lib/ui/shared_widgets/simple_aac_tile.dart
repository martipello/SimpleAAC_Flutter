import 'package:flutter/material.dart';

import '../theme/base_theme.dart';

class SimpleAACTile extends StatelessWidget {
  SimpleAACTile({
    Key? key,
    this.border,
    required this.child,
    this.isSelected = false,
    this.closeButtonOnTap,
    this.closeButtonOnLongPress,
    this.hasReOrderButton = false,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final VoidCallback? closeButtonOnTap;
  final VoidCallback? closeButtonOnLongPress;
  final bool hasReOrderButton;
  final RoundedRectangleBorder? border;

  @override
  Widget build(BuildContext context) {
    final _closeButtonOnTap = closeButtonOnTap;
    return Card(
      key: key,
      elevation: isSelected ? 0 : 2,
      color: isSelected ? colors(context).background : colors(context).white,
      shape: border ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4,
            ),
          ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          child,
          if (_closeButtonOnTap != null)
            buildCloseButton(
              context,
              Alignment.topRight,
              _closeButtonOnTap,
              closeButtonOnLongPress,
            ),
          if (hasReOrderButton)
            buildReOrderButton(
              context,
              Alignment.topLeft,
              () {},
            ),
        ],
      ),
    );
  }

  Widget buildCloseButton(
      BuildContext context, Alignment alignment, VoidCallback closeButtonOnTap, VoidCallback? closeButtonOnLongPress) {
    return _buildTileOverlapButton(
      context,
      alignment,
      Icons.close,
      closeButtonOnTap,
      closeButtonOnLongPress,
    );
  }

  Widget buildReOrderButton(
    BuildContext context,
    Alignment alignment,
    VoidCallback closeButtonOnTap,
  ) {
    return _buildTileOverlapButton(
      context,
      alignment,
      Icons.menu,
      closeButtonOnTap,
      null,
    );
  }

  Widget _buildTileOverlapButton(
    BuildContext context,
    Alignment alignment,
    IconData iconData,
    VoidCallback closeButtonOnTap,
    VoidCallback? closeButtonOnLongPress,
  ) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(
            2.0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              90,
            ),
            child: Container(
              color: Colors.white.withOpacity(
                0.7,
              ),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: closeButtonOnTap,
                  onLongPress: closeButtonOnLongPress,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      4.0,
                    ),
                    child: Icon(
                      iconData,
                      color: colors(context).textOnForeground,
                    ),
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
