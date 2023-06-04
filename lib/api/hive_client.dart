import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'package:path_provider/path_provider.dart';

import '../ui/shared_widgets/my_custom_painter.dart';

const pngFileExtension = '.png';

class HiveClient {
  HiveClient._();

  static late final Box<dynamic> _hiveBox;

  static Future<HiveClient> init<T>(String boxName) async {
    _hiveBox = await Hive.openBox<T>(
      boxName,
    );
    return HiveClient._();
  }

  Future<void> put<T>(
    String key,
    T? value,
  ) async {
    return _hiveBox.put(key, value);
  }

  Future<void> delete(
    String key,
  ) async {
    return _hiveBox.delete(key);
  }

  Future<T?> get<T>(
    String key, {
    T? defaultValue,
  }) async {

    try {
      final loaded = _hiveBox.get(key, defaultValue: defaultValue) as T;
      if (kDebugMode) {
        debugPrint('Hive type   : $key as ${defaultValue.runtimeType}');
        debugPrint('Hive loaded : $key as $loaded with ${loaded.runtimeType}');
      }
      return loaded;
    } catch (e) {
      debugPrint('Hive load (get) ERROR');
      debugPrint(' Error message ...... : $e');
      debugPrint(' Store key .......... : $key');
      debugPrint(' defaultValue ....... : $defaultValue');
      // If something goes wrong we return the default value.
      return defaultValue;
    }
  }

  Future<XFile?> getPNGFile(
    String key,
  ) async {
    final path = await get<String?>(key);
    if (path != null && path.isNotEmpty == true) {
      return FlutterImageCompress.compressAndGetFile(
        path,
        path,
        quality: 88,
        format: CompressFormat.png,
      );
    }
    return null;
  }

  Future<File?> savePNGFile(
    List<Offset?> points,
    Size size,
    String folderName,
    String key,
  ) async {
    final filePath = await getFilePath(
      extension: pngFileExtension,
      folderName: folderName,
    );
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final painter = MyCustomPainter(points);
    painter.paint(canvas, size);
    final image = await recorder.endRecording().toImage(
          size.width.floor(),
          size.height.floor(),
        );
    final byteData = await image.toByteData(
      format: ImageByteFormat.png,
    );
    if (byteData != null) {
      await put(filePath, key);
      return _writeToFile(byteData, filePath);
    }
    return Future.value(null);
  }

  Future<String> getFilePath({
    required String extension,
    required String folderName,
  }) async {
    final _documentsPath = await getApplicationDocumentsDirectory();
    final _simpleAACFolder = Directory(
      '${_documentsPath.path}/meta/$folderName',
    );

    final now = DateTime.now();
    final id = '${now.day}'
        '${now.month}'
        '${now.year}'
        '${now.hour}'
        '${now.minute}'
        '${now.second}'
        '${now.millisecond}'
        '${now.microsecond}';

    if (await _simpleAACFolder.exists()) {
      return '${_simpleAACFolder.path}/$id$extension';
    } else {
      final _simpleAACNewFolder = await _simpleAACFolder.create(
        recursive: true,
      );
      return '${_simpleAACNewFolder.path}/$id$extension';
    }
  }

  Future<File> _writeToFile(
    ByteData data,
    String path,
  ) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
      buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      ),
    );
  }

  Future<void> dispose() async {
    _hiveBox.close();
  }
}
