import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import 'intro_view.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroView(
      title: context.strings?.welcome ?? 'Welcome',
      bodyWidget: _buildWelcomeBody(context),
      descriptionLabel: 'Welcome to Simple AAC.',
    );
  }

  Widget _buildWelcomeBody(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 150,
        maxHeight: 150,
      ),
      child: Image.asset(
        'assets/images/simple_aac.png',
      ),
    );
  }
}
