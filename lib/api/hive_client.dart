import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hive_built_value_flutter/hive_flutter.dart';

const pngFileExtension = '.png';

class HiveClient<T> {
  /// Private constructor
  HiveClient._create(Box<T> box) {
    _hiveBox = box;
  }

  static Future<HiveClient> create<T>(String boxName) async {
    final box = await Hive.openBox<T>(boxName);
    final hiveClient = HiveClient._create(box);
    return hiveClient;
  }

  late final Box _hiveBox;

  Future<void> put(
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
      final loaded = _hiveBox.get(key, defaultValue: defaultValue) as T?;
      return loaded;
    } catch (e) {
      return defaultValue;
    }
  }

  BuiltList<T> getAll<T>() => _hiveBox.values.whereType<T>().toBuiltList();

  Future<BuiltList<T>> getAllForKeys<T>(BuiltList<String> keys) async {
    try {
      final allLoaded = BuiltList<T>();
      for (var key in keys) {
        final loaded = _hiveBox.get(key) as T;
        allLoaded.rebuild((b) => b.add(loaded));
      }
      return allLoaded;
    } catch (e) {
      return BuiltList<T>();
    }
  }

  void addListener(AsyncCallback callback){
    _hiveBox.listenable().addListener(callback);
  }

  void removeListener(AsyncCallback callback){
    _hiveBox.listenable().removeListener(callback);
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

  // Future<File?> savePNGFile(
  //   List<Offset?> points,
  //   Size size,
  //   String folderName,
  //   String key,
  // ) async {
  //   final filePath = await getFilePath(
  //     extension: pngFileExtension,
  //     folderName: folderName,
  //   );
  //   final recorder = PictureRecorder();
  //   final canvas = Canvas(recorder);
  //   final painter = MyCustomPainter(points);
  //   painter.paint(canvas, size);
  //   final image = await recorder.endRecording().toImage(
  //         size.width.floor(),
  //         size.height.floor(),
  //       );
  //   final byteData = await image.toByteData(
  //     format: ImageByteFormat.png,
  //   );
  //   if (byteData != null) {
  //     await put(filePath, key);
  //     return _writeToFile(byteData, filePath);
  //   }
  //   return Future.value(null);
  // }
  //
  // Future<String> getFilePath({
  //   required String extension,
  //   required String folderName,
  // }) async {
  //   final _documentsPath = await getApplicationDocumentsDirectory();
  //   final _simpleAACFolder = Directory(
  //     '${_documentsPath.path}/meta/$folderName',
  //   );
  //
  //   final now = DateTime.now();
  //   final id = '${now.day}'
  //       '${now.month}'
  //       '${now.year}'
  //       '${now.hour}'
  //       '${now.minute}'
  //       '${now.second}'
  //       '${now.millisecond}'
  //       '${now.microsecond}';
  //
  //   if (await _simpleAACFolder.exists()) {
  //     return '${_simpleAACFolder.path}/$id$extension';
  //   } else {
  //     final _simpleAACNewFolder = await _simpleAACFolder.create(
  //       recursive: true,
  //     );
  //     return '${_simpleAACNewFolder.path}/$id$extension';
  //   }
  // }
  //
  // Future<File> _writeToFile(
  //   ByteData data,
  //   String path,
  // ) {
  //   final buffer = data.buffer;
  //   return File(path).writeAsBytes(
  //     buffer.asUint8List(
  //       data.offsetInBytes,
  //       data.lengthInBytes,
  //     ),
  //   );
  // }

  Future<void> dispose() async {
    if(_hiveBox.isOpen) {
      await _hiveBox.close();
    }
  }
}
