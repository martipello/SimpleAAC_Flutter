import 'package:flutter/material.dart';

import '../../ui/shared_widgets/rounded_button.dart';
import '../../ui/theme/simple_aac_text.dart';

class IntroView extends StatelessWidget {
  const IntroView({
    required this.title,
    required this.bodyWidget,
    final Key? key,
    this.actionButtonCallback,
    this.actionButtonFillColor,
    this.actionButtonLabel,
    this.descriptionLabel,
  }) : super(key: key);

  final String title;
  final Widget bodyWidget;
  final Color? actionButtonFillColor;
  final String? actionButtonLabel;
  final String? descriptionLabel;
  final VoidCallback? actionButtonCallback;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 36,
          ),
          _buildTitle(),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 2,
            child: Center(child: bodyWidget),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                descriptionLabel ?? '',
                style: SimpleAACText.h5Style.copyWith(height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          if (actionButtonCallback != null)
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    child: RoundedButton(
                      label: actionButtonLabel ?? '',
                      fillColor: actionButtonFillColor,
                      onPressed: actionButtonCallback,
                    ),
                  ),
                ),
              ),
            ),
          if (actionButtonCallback == null)
            const Expanded(
              flex: 1,
              child: SizedBox(
                height: 60,
              ),
            ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  Padding _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Text(
        title,
        style: SimpleAACText.h2Style.copyWith(
          height: 1.5,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
