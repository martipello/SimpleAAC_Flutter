import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/extensions/build_context_extension.dart';
import 'package:simple_aac/ui/shared_widgets/view_constraint.dart';

//TODO(MS): check if we need to be checking for isMounted
mixin OverlayStateMixin<T extends StatefulWidget> on SingleTickerProviderStateMixin<T> {
  OverlayEntry? _overlayEntry;

  late final _expandedGroupRevealAnimationController = AnimationController(
    vsync: this,
    duration: _duration,
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final _circleRevealAnimation = CurvedAnimation(
    parent: _expandedGroupRevealAnimationController,
    curve: Curves.easeIn,
  );

  final _duration = const Duration(milliseconds: 300);

  bool get isOverlayShown => _overlayEntry != null;

  void toggleOverlay(Widget child) => isOverlayShown ? removeOverlay() : _insertOverlay(child);

  @override
  void dispose() {
    removeOverlay();
    _expandedGroupRevealAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    removeOverlay();
    super.didChangeDependencies();
  }

  Widget _dismissibleOverlay(Widget child) {
    return Stack(
      children: [
        Positioned.fill(
          child: FadeTransition(
            opacity: _expandedGroupRevealAnimationController,
            child: ColoredBox(
              color: context.themeColors.shadow.withOpacity(0.6),
              child: GestureDetector(
                onTap: removeOverlay,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ViewConstraint(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: CircularRevealAnimation(
                animation: _circleRevealAnimation,
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _insertOverlay(Widget child) {
    _overlayEntry = OverlayEntry(
      builder: (_) => _dismissibleOverlay(child),
    );
    Overlay.of(context).insert(_overlayEntry!);
    _expandedGroupRevealAnimationController.forward();
  }

void removeOverlay() {
    _expandedGroupRevealAnimationController.reverse().then((_) {
      _removeOverlay();
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
