import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../extensions/build_context_extension.dart';
import 'theme_builder_widget.dart';
import 'theme_controller.dart';

import '../../view_models/theme_view_model.dart';
import '../dashboard/app_shell.dart';

class ThemePreview extends StatefulWidget {
  const ThemePreview({
    required this.themeViewModel,
    required this.theme,
    required this.isDark,
    final Key? key,
  }) : super(key: key);

  final ThemeViewModel themeViewModel;
  final SimpleAACTheme theme;
  final bool isDark;

  @override
  State<ThemePreview> createState() => _ThemePreviewState();
}

class _ThemePreviewState extends State<ThemePreview> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (final _) async {
        await widget.themeViewModel.init(doSetSavedTheme: false);
        widget.themeViewModel.setTheme(widget.theme);
      },
    );
  }

  @override
  Widget build(final BuildContext context) {
    return _buildConstrainedSizeAppWrapper(
      widget.themeViewModel,
      widget.theme,
    );
  }

  Widget _buildConstrainedSizeAppWrapper(
    final ThemeViewModel themeViewModel,
    final SimpleAACTheme theme,
  ) {
    return Center(
      child: SizedBox(
        height: context.screenHeight * 0.7,
        width: context.screenWidth * 0.7,
        child: _buildUnTappableAppWrapper(
          themeViewModel,
          theme,
        ),
      ),
    );
  }

  Widget _buildUnTappableAppWrapper(
    final ThemeViewModel themeViewModel,
    final SimpleAACTheme theme,
  ) {
    return IgnorePointer(
      child: ThemeBuilderWidget(
        themeViewModel: themeViewModel,
        themeBuilder: (final themeController) {
          return _buildApp(themeController, theme);
        },
      ),
    );
  }

  Widget _buildApp(
    final ThemeController themeController,
    final SimpleAACTheme theme,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildFlexThemeDataLight(themeController),
      darkTheme: _buildFlexThemeDataDark(themeController),
      themeMode: widget.isDark ? ThemeMode.dark : ThemeMode.light,
      home: AppShell(
        title: '${theme.name} ${widget.isDark ? ThemeMode.dark.name : ThemeMode.light.name}',
        isHome: false,
      ),
    );
  }

  ThemeData _buildFlexThemeDataDark(
    final ThemeController themeController,
  ) {
    return FlexThemeData.dark(
      useMaterial3: themeController.useMaterial3,
      colors: FlexColor.schemes[themeController.usedScheme]!.dark,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
      blendLevel: 12,
      appBarElevation: 1,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      typography: Typography.material2021(
        platform: defaultTargetPlatform,
      ),
    );
  }

  ThemeData _buildFlexThemeDataLight(
    final ThemeController themeController,
  ) {
    return FlexThemeData.light(
      useMaterial3: themeController.useMaterial3,
      colors: FlexColor.schemes[themeController.usedScheme]!.light,
      surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
      blendLevel: 10,
      appBarElevation: 0.5,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      typography: Typography.material2021(
        platform: defaultTargetPlatform,
      ),
    );
  }
}
