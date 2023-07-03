import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_aac/utils/stream_helper.dart';
import 'package:built_collection/built_collection.dart';

class MultiImageViewModel {
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
    (event) {
      return List<ImageInfo?>.from(
        [
          event.item1,
          event.item2,
          event.item3,
          event.item4,
        ],
      );
    },
  ).publishValue()..connect().addTo(subscriptions);

  Future<void> requestFourImages(BuiltList<String> imagePaths) async {
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

  Future<ImageStream?> imageStream(String imagePath, int index) async {
    //TODO(MS): images shouldn't be assets fix this when we support importing images
    //TODO(MS): Check the cache first
    if (imagePath.startsWith('assets') | imagePath.startsWith('File')) {
      try {
        final imageData = await rootBundle.load(imagePath);
        final imageProvider = MemoryImage(imageData.buffer.asUint8List());
        return imageProvider.resolve(
          ImageConfiguration.empty,
        );
      } catch (e) {
        return Future.value(null);
      }
    } else {
      final imageProvider = CachedNetworkImageProvider(imagePath);
      return imageProvider.resolve(
        ImageConfiguration.empty,
      );
    }
  }

  ImageStreamListener imageStreamListener(ImageStream imageStream, int index) {
    return ImageStreamListener(
      (image, _) {
        _updateImageResponse(image, index);
        imageStream.removeListener(
          imageStreamListener(imageStream, index),
        );
      },
      onError: (error, stackTrace) {
        _updateImageResponse(null, index);
        imageStream.removeListener(
          imageStreamListener(imageStream, index),
        );
      },
    );
  }

  void _updateImageResponse(ImageInfo? imageInfo, int index) {
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
    imageOne.close();
    imageTwo.close();
    imageThree.close();
    imageFour.close();
    subscriptions.dispose();
  }
}
