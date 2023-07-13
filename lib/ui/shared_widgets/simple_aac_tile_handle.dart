import 'package:flutter/material.dart';
import 'package:great_list_view/great_list_view.dart';
import 'package:simple_aac/ui/shared_widgets/overlay_button.dart';

class SimpleAACTileHandle extends StatelessWidget {
  const SimpleAACTileHandle({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AnimatedListController controller;


  @override
  Widget build(BuildContext context) {
    return OverlayButton(
      iconData: Icons.menu,
      onTap: (){},
      onLongPress: (){},
      onVerticalDragStart: (dd) {
        controller.notifyStartReorder(
          context,
          dd.localPosition.dx,
          dd.localPosition.dy,
        );
      },
      onVerticalDragUpdate: (dd) {
        controller.notifyUpdateReorder(
          dd.localPosition.dx,
          dd.localPosition.dy,
        );
      },
      onVerticalDragEnd: (dd) {
        controller.notifyStopReorder(false);
      },
      onVerticalDragCancel: () {
        controller.notifyStopReorder(true);
      },
    );
  }
}
