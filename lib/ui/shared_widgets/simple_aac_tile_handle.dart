import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'overlay_button.dart';

class SimpleAACTileHandle extends StatelessWidget {
  const SimpleAACTileHandle({
    required this.controller,
    final Key? key,
  }) : super(key: key);

  final AnimatedListController controller;


  @override
  Widget build(final BuildContext context) {
    return OverlayButton(
      iconData: Icons.menu,
      onTap: (){},
      onLongPress: (){},
      onVerticalDragStart: (final dd) {
        controller.notifyStartReorder(
          context,
          dd.localPosition.dx,
          dd.localPosition.dy,
        );
      },
      onVerticalDragUpdate: (final dd) {
        controller.notifyUpdateReorder(
          dd.localPosition.dx,
          dd.localPosition.dy,
        );
      },
      onVerticalDragEnd: (final dd) {
        controller.notifyStopReorder(false);
      },
      onVerticalDragCancel: () {
        controller.notifyStopReorder(true);
      },
    );
  }
}
