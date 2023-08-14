import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../api/services/shared_preferences_service.dart';
import '../../ui/dashboard/app_shell.dart';
import '../../ui/shared_widgets/rounded_button.dart';
import '../../view_models/intro/intro_view_model.dart';
import 'bio_metric_view.dart';
import 'welcome_view.dart';

class IntroPage extends StatelessWidget {
  final controller = PageController(initialPage: 0);
  final _introViewModel = getIt.get<IntroViewModel>();
  final _sharedPreferences = getIt.get<SharedPreferencesService>();

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (final context, final child) {
        final color = controller.hasClients ? controller.page! / 2 : .0;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: TweenSequence([
              TweenSequenceItem(
                tween: ColorTween(
                  begin: Colors.white,
                  end: context.themeColors.primary,
                ),
                weight: 1,
              ),
              TweenSequenceItem(
                tween: ColorTween(
                  begin: Colors.white,
                  end: context.themeColors.primary,
                ),
                weight: 1,
              ),
            ]).evaluate(
              AlwaysStoppedAnimation(color),
            ),
          ),
          child: child,
        );
      },
      child: StreamBuilder<int>(
        stream: _introViewModel.currentPageStream,
        builder: (final context, final snapshot) {
          final pageIndex = snapshot.data ?? 0;
          return SafeArea(
            bottom: true,
            minimum: const EdgeInsets.only(bottom: 16),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: PageView(
                controller: controller,
                onPageChanged: _introViewModel.setCurrentPage,
                children: introViewList(),
              ),
              bottomNavigationBar: _buildBottomNavigationBar(
                context,
                pageIndex != 0,
                true,
                pageIndex,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> introViewList() {
    return [
      WelcomeView(),
      BioMetricView(),
    ];
  }

  Widget _buildBottomNavigationBar(
    final BuildContext context,
    final bool showPreviousButton,
    final bool showNextButton,
    final int pageIndex,
  ) {
    return FutureBuilder<bool>(
      future: Future.value(true),
      builder: (final context, final snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                showPreviousButton ? Icons.arrow_back_ios_new_rounded : null,
                color: context.themeColors.onBackground,
              ),
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
            ),
            SmoothPageIndicator(
              controller: controller,
              count: introViewList().length,
              effect: SlideEffect(
                dotHeight: 16,
                dotWidth: 16,
                dotColor: context.themeColors.background,
                activeDotColor: context.themeColors.secondary,
              ),
            ),
            pageIndex == introViewList().length - 1
                ? RoundedButton(
                    label: 'Done',
                    onPressed: () async {
                      _sharedPreferences.setFirstTime(isFirstTime: false);
                      await Navigator.of(context).pushReplacementNamed(AppShell.routeName);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      showNextButton ? Icons.arrow_forward_ios_rounded : null,
                      color: context.themeColors.background,
                    ),
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}
