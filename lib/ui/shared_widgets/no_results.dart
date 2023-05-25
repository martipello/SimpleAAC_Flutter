import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    Key? key,
    this.emptyMessage,
    this.emptyImage,
  }) : super(key: key);

  final String? emptyMessage;
  final Widget? emptyImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            emptyImage ??
                Icon(
                  Icons.hourglass_empty_outlined,
                  size: 120,
                  color: context.themeColors.onBackground,
                ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 36.0,
              ),
              child: Text(
                'Your all caught up. You can swipe down to check for more content.',
                style: SimpleAACText.body1Style,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
