import 'package:flutter/material.dart';
import '../theme/base_theme.dart';

class SimpleAACIconButton extends StatelessWidget {
  SimpleAACIconButton({
    Key? key,
    required this.callback,
    required this.iconData,
    this.iconColor,
    this.iconSize,
    this.disabledColor,
  }) : super(key: key);

  final VoidCallback? callback;
  final IconData iconData;
  final Color? iconColor;
  final Color? disabledColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(90),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: callback,
          child: SizedBox(
            height: _getIconHolderSize(),
            width: _getIconHolderSize(),
            child: Icon(
              iconData,
              color: callback != null
                  ? iconColor ?? colors(context).secondary
                  : disabledColor ?? colors(context).chromeLighter,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }

  double _getIconHolderSize() {
    final _iconSize = iconSize ?? 20;
    return _iconSize + 16;
  }
}
