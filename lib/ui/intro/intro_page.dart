import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../services/shared_preferences_service.dart';
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final color = controller.hasClients ? controller.page! / 2 : .0;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: TweenSequence([
              TweenSequenceItem(
                tween: ColorTween(
                  begin: Colors.white,
                  end: context.themeColors.primary,
                ),
                weight: 1.0,
              ),
              TweenSequenceItem(
                tween: ColorTween(
                  begin: Colors.white,
                  end: context.themeColors.primary,
                ),
                weight: 1.0,
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
        builder: (context, snapshot) {
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
    BuildContext context,
    bool showPreviousButton,
    bool showNextButton,
    int pageIndex,
  ) {
    return FutureBuilder<bool>(
      future: Future.value(true),
      builder: (context, snapshot) {
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
                      final sharedPreferences = await _sharedPreferences;
                      sharedPreferences.setFirstTime(isFirstTime: false);
                      Navigator.of(context).pushReplacementNamed(AppShell.routeName);
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
