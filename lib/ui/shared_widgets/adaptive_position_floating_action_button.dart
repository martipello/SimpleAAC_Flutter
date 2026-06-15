import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../../extensions/media_query_extension.dart';

class AdaptivePositionFloatingActionButton extends StatelessWidget {
  const AdaptivePositionFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isWideScreen = context.isWideScreen;
    final rightPadding = MediaQuery.of(context).minContentWidthInset;
    return Padding(
      padding: EdgeInsets.only(
        right: isWideScreen ? rightPadding : 0,
        bottom: MediaQuery.of(context).isNarrowScreen ? 0 : kIsWeb ? kBottomNavigationBarHeight : 0,
      ),
      child: FloatingActionButton(
        heroTag: null,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
