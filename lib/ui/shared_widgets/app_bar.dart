import 'package:flutter/material.dart';

import '../theme/base_theme.dart';
import '../theme/simple_aac_text.dart';

class SimpleAACAppBar extends StatelessWidget implements PreferredSizeWidget {
  SimpleAACAppBar({
    required this.label,
    this.bottom,
    this.leadingIcon,
    this.actions, this.color,
  }) : preferredSize = Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
  );

  final String label;
  final PreferredSizeWidget? bottom;
  final Widget? leadingIcon;
  final List<Widget>? actions;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? colors(context).primary,
      title: Text(
        label.toUpperCase(),
        style: SimpleAACText.subtitle2Style.copyWith(
          color: colors(context).textOnPrimary,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
      leading: leadingIcon,
      automaticallyImplyLeading: true,
    );
  }

  @override
  final Size preferredSize;
}
