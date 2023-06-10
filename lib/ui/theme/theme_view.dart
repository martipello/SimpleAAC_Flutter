import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../../view_models/theme_view_model.dart';
import '../dashboard/app_shell.dart';
import '../shared_widgets/app_bar.dart';
import '../shared_widgets/bottom_button_holder.dart';
import '../shared_widgets/rounded_button.dart';
import '../shared_widgets/simple_aac_loading_widget.dart';
import 'theme_builder_widget.dart';
import 'theme_controller.dart';

class ThemeView extends StatefulWidget {
  static const String routeName = '/theme';

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  final _themeViewModelRed = getIt.get<ThemeViewModel>();
  final _themeViewModelYellow = getIt.get<ThemeViewModel>();
  final _themeViewModelGreen = getIt.get<ThemeViewModel>();
  final _themeViewModelBlue = getIt.get<ThemeViewModel>();
  final _themeViewModelPink = getIt.get<ThemeViewModel>();
  final _themeViewModelPurple = getIt.get<ThemeViewModel>();

  var _themePageIndex = 0;
  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = context.isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(
        label: 'Choose a theme',
      ),
      body: PageView(
        onPageChanged: (index) {
          _themePageIndex = index;
        },
        children: _themePages()
            .map(
              (themeViewModelAndTheme) => _buildThemeWrappedApp(
                themeViewModelAndTheme.item1,
                themeViewModelAndTheme.item2,
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: _buildBottomButtonHolder(),
      floatingActionButton: _buildDarkSwitchButton(),
    );
  }

  List<Tuple2> _themePages() {
    return [
      Tuple2(
        _themeViewModelRed,
        SimpleAACTheme.red,
      ),
      Tuple2(
        _themeViewModelBlue,
        SimpleAACTheme.blue,
      ),
      Tuple2(
        _themeViewModelYellow,
        SimpleAACTheme.yellow,
      ),
      Tuple2(
        _themeViewModelGreen,
        SimpleAACTheme.green,
      ),
      Tuple2(
        _themeViewModelPink,
        SimpleAACTheme.pink,
      ),
      Tuple2(
        _themeViewModelPurple,
        SimpleAACTheme.purple,
      ),
    ];
  }

  Widget _buildThemeWrappedApp(
    ThemeViewModel themeViewModel,
    SimpleAACTheme theme,
  ) {
    return FutureBuilder<void>(
      future: themeViewModel.init(doSetInitialTheme: false),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading();
        }
        themeViewModel.setTheme(theme);
        return _buildConstrainedSizeAppWrapper(
          themeViewModel,
          theme,
        );
      },
    );
  }

  Widget _buildConstrainedSizeAppWrapper(
    ThemeViewModel themeViewModel,
    SimpleAACTheme theme,
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
    ThemeViewModel themeViewModel,
    SimpleAACTheme theme,
  ) {
    return IgnorePointer(
      child: ThemeBuilderWidget(
        themeViewModel: themeViewModel,
        themeBuilder: (themeController) {
          return _buildApp(themeController, theme);
        },
      ),
    );
  }

  Widget _buildApp(
    ThemeController themeController,
    SimpleAACTheme theme,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildFlexThemeDataLight(themeController),
      darkTheme: _buildFlexThemeDataDark(themeController),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: AppShell(
        title: '${theme.name} ${isDark ? ThemeMode.dark.name : ThemeMode.light.name}',
      ),
    );
  }

  ThemeData _buildFlexThemeDataDark(
    ThemeController themeController,
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
    ThemeController themeController,
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

  Widget _buildDarkSwitchButton() {
    return FloatingActionButton(
      child: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      ),
      onPressed: () {
        setState(
          () {
            isDark = !isDark;
          },
        );
      },
    );
  }

  Widget _buildBottomButtonHolder() {
    return BottomButtonHolder(
      child: RoundedButton(
        label: 'Set Theme',
        onPressed: () {
          context.themeViewModel.setThemeMode(
            isDark ? ThemeMode.dark : ThemeMode.light,
          );
          context.themeViewModel.setTheme(
            _themePages().get(_themePageIndex).item2,
          );
        },
      ),
    );
  }

  Center _buildLoading() {
    return const Center(
      child: SimpleAACLoadingWidget(),
    );
  }
}
