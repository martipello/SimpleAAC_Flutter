import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../dependency_injection_container.dart';
import '../services/ai_prediction_service.dart';
import 'draw_word_view.dart';

class PickImageDialog extends StatefulWidget {
  const PickImageDialog({
    Key? key,
    this.wordText,
    this.onAiGenerating,
  }) : super(key: key);

  final String? wordText;

  /// Called when AI generation starts. Receives the generation [Future] so the
  /// caller can show a loading state while the sheet is dismissed.
  final void Function(Future<String?> future)? onAiGenerating;

  static Future<String?> show(
    BuildContext context, {
    String? wordText,
    void Function(Future<String?> future)? onAiGenerating,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (context) => PickImageDialog(
        wordText: wordText,
        onAiGenerating: onAiGenerating,
      ),
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
  final _aiService = getIt.get<AiPredictionService>();

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

  Future<void> _generateWithAi() async {
    final hasKey = await _aiService.hasOpenAiKey();
    if (!hasKey) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add an OpenAI key in Settings → Speech to generate images with AI'),
          ),
        );
      }
      return;
    }

    final controller = TextEditingController(text: widget.wordText ?? '');
    final prompt = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Generate with AI'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Describe the image',
            hintText: 'e.g. happy, eat, school bus',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => Navigator.of(ctx).pop(controller.text.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (prompt == null || prompt.isEmpty || !mounted) return;

    // Hand the generation future to the parent, then dismiss the sheet so the
    // parent can show a shimmer on the image while generation runs in the background.
    widget.onAiGenerating?.call(_aiService.generateImage(prompt));
    Navigator.of(context).pop(null);
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
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 12) / 2;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildOption(
                      width: itemWidth,
                      icon: Icons.camera_alt_rounded,
                      label: 'Camera',
                      color: const Color(0xFF4FC3F7),
                      onTap: _pickFromCamera,
                    ),
                    _buildOption(
                      width: itemWidth,
                      icon: Icons.photo_library_rounded,
                      label: 'Gallery',
                      color: const Color(0xFF81C784),
                      onTap: _pickFromGallery,
                    ),
                    _buildOption(
                      width: itemWidth,
                      icon: Icons.brush_rounded,
                      label: 'Draw',
                      color: const Color(0xFFFFB74D),
                      onTap: _pickFromDraw,
                    ),
                    _buildOption(
                      width: itemWidth,
                      icon: Icons.auto_awesome_rounded,
                      label: 'Generate',
                      color: const Color(0xFFBA68C8),
                      onTap: _generateWithAi,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required double width,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: width,
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
