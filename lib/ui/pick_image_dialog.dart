import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../dependency_injection_container.dart';
import 'draw_word_view.dart';

class PickImageDialog extends StatefulWidget {
  const PickImageDialog({Key? key}) : super(key: key);

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (context) => const PickImageDialog(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  @override
  _PickImageDialogState createState() => _PickImageDialogState();
}

class _PickImageDialogState extends State<PickImageDialog> {
  final _picker = getIt.get<ImagePicker>();
  final _cropper = ImageCropper();

  Future<void> _pickFromCamera() async {
    final file = await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (file == null) return;
    await _cropAndReturn(file.path);
  }

  Future<void> _pickFromDraw() async {
    final path = await DrawWordView.show(context);
    if (path == null) {
      if (mounted) Navigator.of(context).pop(null);
      return;
    }
    await _cropAndReturn(path);
  }

  Future<void> _pickFromGallery() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (file == null) return;
    await _cropAndReturn(file.path);
  }

  Future<void> _cropAndReturn(String sourcePath) async {
    if (kIsWeb) {
      // image_cropper doesn't support web; return the image path as-is.
      if (mounted) Navigator.of(context).pop(sourcePath);
      return;
    }
    final cropped = await _cropper.cropImage(
      sourcePath: sourcePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(lockAspectRatio: true),
        IOSUiSettings(aspectRatioLockEnabled: true, resetAspectRatioEnabled: false),
      ],
    );
    if (mounted) Navigator.of(context).pop(cropped?.path);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Add a picture!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildOption(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  color: const Color(0xFF4FC3F7),
                  onTap: _pickFromCamera,
                ),
                const SizedBox(width: 12),
                _buildOption(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  color: const Color(0xFF81C784),
                  onTap: _pickFromGallery,
                ),
                const SizedBox(width: 12),
                _buildOption(
                  icon: Icons.brush_rounded,
                  label: 'Draw',
                  color: const Color(0xFFFFB74D),
                  onTap: _pickFromDraw,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 2),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
