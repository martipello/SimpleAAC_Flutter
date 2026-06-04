import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../dependency_injection_container.dart';
import 'shared_widgets/my_custom_painter.dart';

class DrawWordView extends StatefulWidget {
  const DrawWordView({super.key});

  static Future<String?> show(BuildContext context) {
    return Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => const DrawWordView(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<DrawWordView> createState() => _DrawWordViewState();
}

class _DrawWordViewState extends State<DrawWordView> {
  final _repaintKey = GlobalKey();
  final _picker = getIt.get<ImagePicker>();
  final List<List<Offset?>> _strokes = [];
  List<Offset?> _currentStroke = [];
  File? _backgroundImage;

  Color _selectedColor = Colors.black;
  double _strokeWidth = 4;

  static const _colors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.white,
  ];

  static const _strokeWidths = [2.0, 4.0, 8.0, 14.0];

  List<Offset?> get _allPoints {
    final points = <Offset?>[];
    for (final stroke in _strokes) {
      points.addAll(stroke);
      points.add(null); // separator
    }
    return points;
  }

  void _onPanStart(DragStartDetails d) {
    _currentStroke = [d.localPosition];
    setState(() {});
  }

  void _onPanUpdate(DragUpdateDetails d) {
    _currentStroke.add(d.localPosition);
    setState(() {});
  }

  void _onPanEnd(DragEndDetails _) {
    _strokes.add([..._currentStroke, null]);
    _currentStroke = [];
    setState(() {});
  }

  void _undo() {
    if (_strokes.isNotEmpty) setState(() => _strokes.removeLast());
  }

  void _clear() => setState(() {
        _strokes.clear();
        _currentStroke = [];
      });

  Future<void> _pickBackground(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 100);
    if (file != null) setState(() => _backgroundImage = File(file.path));
  }

  Future<void> _save() async {
    final boundary = _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) return;

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/draw_${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(bytes.buffer.asUint8List());

    if (mounted) Navigator.of(context).pop(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw'),
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: _strokes.isEmpty ? null : _undo),
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: _strokes.isEmpty ? null : _clear),
          FilledButton(
            onPressed: _strokes.isEmpty ? null : _save,
            child: const Text('Done'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: RepaintBoundary(
                key: _repaintKey,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _backgroundImage != null
                        ? Image.file(_backgroundImage!, fit: BoxFit.cover)
                        : const ColoredBox(color: Colors.white),
                    CustomPaint(
                      painter: MyCustomPainter(
                        [..._allPoints, ..._currentStroke],
                        color: _selectedColor,
                        strokeWidth: _strokeWidth,
                        hasBackground: _backgroundImage != null,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildToolbar(),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorRow(),
            const SizedBox(height: 8),
            _buildStrokeRow(),
            const SizedBox(height: 8),
            _buildBackgroundRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _colors.map((color) {
        final selected = _selectedColor == color;
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: selected ? 34 : 28,
            height: selected ? 34 : 28,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Theme.of(context).colorScheme.primary : Colors.grey.shade400,
                width: selected ? 3 : 1,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBackgroundRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: () => _pickBackground(ImageSource.gallery),
          icon: const Icon(Icons.photo_library_rounded, size: 18),
          label: const Text('Background from gallery'),
        ),
        if (_backgroundImage != null) ...[
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Remove background',
            icon: const Icon(Icons.close),
            onPressed: () => setState(() => _backgroundImage = null),
          ),
        ],
      ],
    );
  }

  Widget _buildStrokeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _strokeWidths.map((width) {
        final selected = _strokeWidth == width;
        return GestureDetector(
          onTap: () => setState(() => _strokeWidth = width),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Container(
                width: width * 1.8,
                height: width * 1.8,
                decoration: BoxDecoration(
                  color: _selectedColor == Colors.white ? Colors.grey : _selectedColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
