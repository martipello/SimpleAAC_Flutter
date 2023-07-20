import 'package:flutter/material.dart';

import '../theme/simple_aac_text.dart';

class NoResults extends StatelessWidget {
  const NoResults({
    final Key? key,
    this.emptyMessage,
    this.emptyImage,
  }) : super(key: key);

  final String? emptyMessage;
  final Widget? emptyImage;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            emptyImage ??
                const Icon(
                  Icons.hourglass_empty_outlined,
                  size: 120,
                ),
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 36,
              ),
              child: Text(
                'No results. Try swiping down to refresh.',
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
