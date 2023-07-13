import 'package:flutter/material.dart';
import 'package:simple_aac/ui/theme/theme_preview.dart';
import 'package:tuple/tuple.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../../view_models/theme_view_model.dart';
import '../shared_widgets/app_bar.dart';
import '../shared_widgets/bottom_button_holder.dart';
import '../shared_widgets/rounded_button.dart';

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
              (themeViewModelAndTheme) => ThemePreview(
                themeViewModel: themeViewModelAndTheme.item1,
                theme: themeViewModelAndTheme.item2,
                isDark: isDark,
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

  Widget _buildDarkSwitchButton() {
    return FloatingActionButton(
      child: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
      ),
      onPressed: () {
        if (mounted) {
          setState(
            () {
              isDark = !isDark;
            },
          );
        }
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
}
