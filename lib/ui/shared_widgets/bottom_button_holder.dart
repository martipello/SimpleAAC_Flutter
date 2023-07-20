import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

class BottomButtonHolder extends StatelessWidget {
  const BottomButtonHolder({
    required this.child,
    final Key? key,
    this.hasShadow = false,
    this.color,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final bool hasShadow;
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: hasShadow
          ? BoxDecoration(
              boxShadow: <BoxShadow>[
                const BoxShadow(
                  color: Color(
                    0x26000000,
                  ),
                  offset: Offset(
                    0,
                    -1,
                  ),
                  blurRadius: 6,
                ),
              ],
              color: color ?? context.themeColors.background,
            )
          : null,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: SafeArea(
            bottom: true,
            minimum: EdgeInsets.only(
              bottom: padding?.bottom ?? 16,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                right: padding?.right ?? 16,
                left: padding?.left ?? 16,
                top: padding?.top ?? 14,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
