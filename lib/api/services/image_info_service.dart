import 'package:built_collection/built_collection.dart';

import '../hive_client.dart';
import '../models/image_info.dart';

const kImageInfoBox = 'image_info_box';

class ImageInfoService {
  ImageInfoService(this.hiveClient);

  final HiveClient hiveClient;

  Future<void> put(final ImageInfo imageInfo) {
    return hiveClient.put(
      imageInfo.id,
      imageInfo,
    );
  }

  Future<void> putAll(final BuiltList<ImageInfo> imageInfos) async {
    for (var imageInfo in imageInfos) {
      await put(
        imageInfo,
      );
    }
  }

  BuiltList<ImageInfo> getImages(
    final BuiltList<String> imageIds,
  ) {
    return hiveClient.getAllForKeys<ImageInfo>(imageIds);
  }

  Future<void> deleteAll() async {
    await hiveClient.deleteAll();
  }
}
