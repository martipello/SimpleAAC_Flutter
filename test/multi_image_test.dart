import 'package:built_collection/built_collection.dart';
import 'package:file/memory.dart';
import 'package:flutter/services.dart';
@GenerateNiceMocks([MockSpec<DefaultCacheManager>()])
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:simple_aac/ui/shared_widgets/view_model/multi_image_view_model.dart';

import 'fake_path_provider_platform.dart';
import 'multi_image_test.mocks.dart';

void main() {
  final assetImageList = BuiltList.of([
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
  ]);

  final assetImageErrorList = BuiltList.of([
    'assets/images/error.png',
    'assets/images/error.png',
    'assets/images/error.png',
    'assets/images/error.png',
  ]);

  final assetImageHalfErrorList = BuiltList.of([
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/error.png',
    'assets/images/error.png',
  ]);

  final fileImageErrorList = BuiltList.of([
    'file/images/error.png',
    'file/images/error.png',
    'file/images/error.png',
    'file/images/error.png',
  ]);

  setUpAll(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
  });

  group(
    'MultiImage test',
    () {
      test(
        'One image to load them all! load one load all',
        () async {
          TestWidgetsFlutterBinding.ensureInitialized();
          final mockDefaultCacheManager = await setUpMockCacheManager(assetImageList);
          final multiImageViewModel = MultiImageViewModel(
            mockDefaultCacheManager,
          );

          multiImageViewModel.fourImages.listen(
            (final images) {
              expect(images.length, 4);
              final notNullImages = images.where((final element) => element != null);
              expect(notNullImages.length, 4);
            },
          );
          await multiImageViewModel.requestFourImages(assetImageList);
          await Future.delayed(Duration(seconds: 10));
        },
      );

      test(
        'All errors all the time',
        () async {
          TestWidgetsFlutterBinding.ensureInitialized();
          final mockDefaultCacheManager = await setUpMockCacheManager(assetImageErrorList);
          final multiImageViewModel = MultiImageViewModel(
            mockDefaultCacheManager,
          );

          multiImageViewModel.fourImages.listen(
            (final images) {
              expect(images.length, 4);
              final notNullImages = images.where((final element) => element != null);
              expect(notNullImages.length, 0);
            },
          );
          await multiImageViewModel.requestFourImages(assetImageErrorList);
          await Future.delayed(Duration(seconds: 10));
        },
      );

      test(
        'Half errors',
        () async {
          TestWidgetsFlutterBinding.ensureInitialized();
          final mockDefaultCacheManager = await setUpMockCacheManager(assetImageHalfErrorList);
          final multiImageViewModel = MultiImageViewModel(
            mockDefaultCacheManager,
          );
          multiImageViewModel.fourImages.listen(
            (final images) {
              expect(images.length, 4);
              final notNullImages = images.where((final element) => element != null);
              expect(notNullImages.length, 2);
            },
          );
          await multiImageViewModel.requestFourImages(assetImageHalfErrorList);
          await Future.delayed(Duration(seconds: 10));
        },
      );

      test(
        'File errors',
        () async {
          TestWidgetsFlutterBinding.ensureInitialized();
          final mockDefaultCacheManager = await setUpMockCacheManager(fileImageErrorList);
          final multiImageViewModel = MultiImageViewModel(
            mockDefaultCacheManager,
          );
          multiImageViewModel.fourImages.listen(
            (final images) {
              expect(images.length, 4);
              final notNullImages = images.where((final element) => element != null);
              expect(notNullImages.length, 0);
            },
          );
          await multiImageViewModel.requestFourImages(fileImageErrorList);
          await Future.delayed(Duration(seconds: 10));
        },
      );
    },
  );
}

Future<MockDefaultCacheManager> setUpMockCacheManager(
  final BuiltList<String> assetImageList,
) async {
  final mockDefaultCacheManager = MockDefaultCacheManager();
  final fileSystem = MemoryFileSystem();

  final byteData = await rootBundle.load('assets/images/simple_aac.png');

  final tempDirectory = await fileSystem.systemTempDirectory.createTemp('example_');
  final outputFile = tempDirectory.childFile('assets/images/simple_aac.png');
  final bytes = Uint8List.view(byteData.buffer);
  //throws FileSystemException: No such file or directory, path = '.tmp_rand0/example_rand0/assets' (OS Error: No such file or directory, errno = 2)
  outputFile.writeAsBytesSync(bytes);


  for (var image in assetImageList) {
    when(mockDefaultCacheManager.getFileFromCache(image)).thenAnswer(
      (final _) async {
        final outputFile = tempDirectory.childFile(image);
        return FileInfo(
          outputFile,
          FileSource.Cache,
          DateTime.now(),
          image,
        );
      },
    );

  }
  return mockDefaultCacheManager;
}
