import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';

import '../../view_models/theme_view_model.dart';
import 'theme_controller.dart';

typedef ThemeBuilder = Widget Function(ThemeController controller);

class ThemeBuilderWidget extends InheritedWidget {
  ThemeBuilderWidget({
    required this.themeBuilder,
    required this.themeViewModel,
    super.key,
  }) : super(
          child: ChangeNotifierBuilder(
            notifier: themeViewModel.themeController,
            builder: (context, _, child) {
              return themeBuilder.call(
                themeViewModel.themeController,
              );
            },
          ),
        );

  final ThemeBuilder themeBuilder;
  final ThemeViewModel themeViewModel;

  static ThemeBuilderWidget of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ThemeBuilderWidget>();
    assert(result != null, 'No ThemeBuilderWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeBuilderWidget old) {
    return false;
  }
}

