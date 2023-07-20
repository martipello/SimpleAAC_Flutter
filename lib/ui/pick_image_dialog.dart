import 'package:flutter/material.dart';

import '../extensions/build_context_extension.dart';
import 'theme/simple_aac_text.dart';

class PickImageDialog extends StatefulWidget {
  PickImageDialog({
    final Key? key,
  }) : super(key: key);

  static Future<bool?> show(
    final BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (final context) {
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
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildIconButton(
                iconData: Icons.camera_alt,
                label: 'Camera',
              ),
              _buildIconButton(
                iconData: Icons.image_rounded,
                label: 'Gallery',
              ),
              _buildIconButton(
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
    required final IconData iconData,
    required final String label,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: TextButton(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Icon(
                  iconData,
                  color: context.themeColors.onBackground,
                ),
              ),
              Text(
                label,
                style: SimpleAACText.body1Style,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
