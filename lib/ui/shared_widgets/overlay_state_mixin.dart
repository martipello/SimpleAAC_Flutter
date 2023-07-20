import 'package:flutter/material.dart';
import 'package:simple_aac/extensions/build_context_extension.dart';

mixin OverlayStateMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  bool get isOverlayShown => _overlayEntry != null;

  void toggleOverlay(Widget child) => isOverlayShown ? removeOverlay() : _insertOverlay(child);

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    removeOverlay();
    super.didChangeDependencies();
  }

  Widget _dismissibleOverlay(Widget child) => Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: context.themeColors.shadow,
              child: GestureDetector(
                onTap: removeOverlay,
              ),
            ),
          ),
          child,
        ],
      );

  // 5
  void _insertOverlay(Widget child) {
    _overlayEntry = OverlayEntry(
      builder: (_) => _dismissibleOverlay(child),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }
}
