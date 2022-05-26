import 'package:flutter/material.dart';

import 'theme/base_theme.dart';
import 'theme/simple_aac_text.dart';

class PickImageDialog extends StatefulWidget {
  PickImageDialog({
    Key? key,
  }) : super(key: key);

  static Future<bool?> show(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return PickImageDialog();
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  @override
  _PickImageDialogState createState() => _PickImageDialogState();
}

class _PickImageDialogState extends State<PickImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildIconButton(
                context: context,
                iconData: Icons.camera_alt,
                label: 'Camera',
              ),
              _buildIconButton(
                context: context,
                iconData: Icons.image_rounded,
                label: 'Gallery',
              ),
              _buildIconButton(
                context: context,
                iconData: Icons.brush_rounded,
                label: 'Draw',
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required BuildContext context,
    required IconData iconData,
    required String label,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: TextButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Icon(
                  iconData,
                  color: colors(context).textOnForeground,
                ),
              ),
              Text(
                label,
                style: SimpleAACText.body1Style,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
