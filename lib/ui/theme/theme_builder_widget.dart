import 'package:flutter/material.dart';

import '../../dependency_injection_container.dart' as di;
import '../../view_models/theme_view_model.dart';
import 'theme_controller.dart';

typedef ThemeBuilder = Widget Function(ThemeController controller);

class ThemeBuilderWidget extends StatefulWidget {
  ThemeBuilderWidget({
    Key? key,
    required this.themeBuilder,
  }) : super(key: key);

  final ThemeBuilder themeBuilder;

  @override
  State<ThemeBuilderWidget> createState() => _ThemeBuilderWidgetState();
}

class _ThemeBuilderWidgetState extends State<ThemeBuilderWidget> {
  final themeViewModel = di.getIt.get<ThemeViewModel>();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeViewModel.themeController,
      builder: (context, child) {
        return widget.themeBuilder.call(
          themeViewModel.themeController,
        );
      },
    );
  }
}
