import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

class SimpleAACAppBar extends StatelessWidget implements PreferredSizeWidget {
  SimpleAACAppBar({
    required this.label,
    this.bottom,
    this.leadingIcon,
    this.actions,
  }) : preferredSize = Size.fromHeight(
          kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
        );

  final String label;
  final PreferredSizeWidget? bottom;
  final Widget? leadingIcon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        label.toUpperCase(),
        style: SimpleAACText.subtitle2Style.copyWith(
          color: context.themeColors.onPrimaryContainer,
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
