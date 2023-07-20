import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utils/stream_helper.dart';

class MultiImageViewModel {

  MultiImageViewModel(this.defaultCacheManager);

  final DefaultCacheManager defaultCacheManager;

  final subscriptions = CompositeSubscription();

  final imageOne = BehaviorSubject<ImageInfo?>();
  final imageTwo = BehaviorSubject<ImageInfo?>();
  final imageThree = BehaviorSubject<ImageInfo?>();
  final imageFour = BehaviorSubject<ImageInfo?>();

  late final fourImages = combine4<ImageInfo?, ImageInfo?, ImageInfo?, ImageInfo?>(
    imageOne,
    imageTwo,
    imageThree,
    imageFour,
  ).map(
    (final event) {
      return List<ImageInfo?>.from(
        [
          event.item1,
          event.item2,
          event.item3,
          event.item4,
        ],
      );
    },
  ).publishValue()
    ..connect().addTo(subscriptions);

  Future<void> requestFourImages(final BuiltList<String> imagePaths) async {
    final paddedList = [...imagePaths, '', '', '', ''];
    final firstFourImagePaths = paddedList.take(4).toList();

    for (var i = 0; i < firstFourImagePaths.length; i++) {
      if (firstFourImagePaths[i].isEmpty) {
        _updateImageResponse(null, i);
      } else {
        final _imageStream = await imageStream(firstFourImagePaths[i], i);
        if (_imageStream != null) {
          _imageStream.addListener(
            imageStreamListener(_imageStream, i),
          );
        } else {
          _updateImageResponse(null, i);
        }
      }
    }
  }

  Future<ImageStream?> imageStream(final String imagePath, final int index) async {
    //TODO(MS): images shouldn't be assets remove this when we support importing images
    //TODO(MS): Check the cache first
    ImageProvider? imageProvider;

    final fileInfo = await defaultCacheManager.getFileFromCache(imagePath);

    if (fileInfo != null) {
      imageProvider = FileImage(fileInfo.file);
    } else if (imagePath.startsWith('assets')) {
      imageProvider = AssetImage(imagePath);
    } else if (imagePath.startsWith('File')) {
      imageProvider = FileImage(File(imagePath));
    } else if (imagePath.startsWith('http')) {
      imageProvider = CachedNetworkImageProvider(
        imagePath,
        cacheManager: defaultCacheManager,
      );
    } else {
      return Future.value(null);
    }
    return imageProvider.resolve(
      ImageConfiguration.empty,
    );

  }

  ImageStreamListener imageStreamListener(
    final ImageStream imageStream,
    final int index,
  ) {
    return ImageStreamListener(
      (final image, final _) {
        _updateImageResponse(image, index);
        imageStream.removeListener(
          imageStreamListener(imageStream, index),
        );
      },
      onError: (final error, final stackTrace) {
        _updateImageResponse(null, index);
        imageStream.removeListener(
          imageStreamListener(imageStream, index),
        );
      },
    );
  }

  void _updateImageResponse(final ImageInfo? imageInfo, final int index) {
    switch (index) {
      case 0:
        imageOne.add(imageInfo);
        break;
      case 1:
        imageTwo.add(imageInfo);
        break;
      case 2:
        imageThree.add(imageInfo);
        break;
      case 3:
        imageFour.add(imageInfo);
        break;
    }
  }

  void dispose() {
    final imageOneInfo = imageOne.valueOrNull;
    final imageTwoInfo = imageTwo.valueOrNull;
    final imageThreeInfo = imageThree.valueOrNull;
    final imageFourInfo = imageFour.valueOrNull;
    imageOneInfo?.dispose();
    imageTwoInfo?.dispose();
    imageThreeInfo?.dispose();
    imageFourInfo?.dispose();
    imageOne.close();
    imageTwo.close();
    imageThree.close();
    imageFour.close();
    subscriptions.dispose();
  }
}
