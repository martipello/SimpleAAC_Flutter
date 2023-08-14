import 'package:built_collection/built_collection.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:simple_aac/api/hive_client.dart';
import 'package:simple_aac/api/services/image_info_service.dart';
import 'package:simple_aac/ui/shared_widgets/multi_image.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_loading_widget.dart';
import 'package:simple_aac/ui/shared_widgets/view_model/multi_image_view_model.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'fake_path_provider_platform.dart';

void main() {

  const singleErrorImage = [
    'assets/images/error.png',
  ];
  const dualErrorImages = [
    'assets/images/error.png',
    'assets/images/error.png',
  ];
  const dualImageSingleErrorImages = [
    'assets/images/error.png',
    'assets/images/simple_aac.png',
  ];
  const singleImage = [
    'assets/images/simple_aac.png',
  ];
  const dualImages = [
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
  ];
  const tripleImages = [
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
  ];
  const quadrupleImages = [
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
  ];
  const multipleImages = [
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
  ];

  setUpAll(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets(
    'multi image test 1 image',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(singleImage);
          await mockNetworkImagesFor(() => tester.pumpWidget(multiImageWidget));
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          await tester.pump();
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          expect(image, findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'multi image test 2 images',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(dualImages,);
          await mockNetworkImagesFor(() => tester.pumpWidget(multiImageWidget),);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          expect(image, findsNWidgets(2));
        },
      );
    },
  );

  testWidgets(
    'multi image test 3 images',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(tripleImages,);
          await mockNetworkImagesFor(() => tester.pumpWidget(multiImageWidget),);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          expect(image, findsNWidgets(3));
        },
      );
    },
  );

  testWidgets(
    'multi image test 4 images',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(quadrupleImages,);
          await tester.pumpWidget(multiImageWidget);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          expect(image, findsNWidgets(4));
        },
      );
    },
  );

  testWidgets(
    'multi image test 6 images',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(multipleImages,);
          await tester.pumpWidget(multiImageWidget);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          final text = find.descendant(
            of: find.byType(MultiImage),
            matching: find.text('+2'),
          );
          expect(image, findsNWidgets(4));
          expect(text, findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'multi image single image error test',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(singleErrorImage,);
          await tester.pumpWidget(multiImageWidget);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          final error = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byIcon(Icons.error_outline_outlined),
          );
          expect(image, findsNothing);
          expect(error, findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'multi image dual image error test',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(dualErrorImages,);
          await tester.pumpWidget(multiImageWidget);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          final error = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byIcon(Icons.error_outline_outlined),
          );
          expect(image, findsNothing);
          expect(error, findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'multi image dual image single error test',
    (final tester) async {
      await tester.runAsync(
        () async {
          final multiImageWidget = await _buildMultiImageWidgetHolder(dualImageSingleErrorImages,);
          await tester.pumpWidget(multiImageWidget);
          final multiImage = find.byType(MultiImage);
          expect(multiImage, findsOneWidget);
          final loading = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(SimpleAACLoadingWidget),
          );
          expect(loading, findsOneWidget);
          await _delayAndPump(tester, Duration(seconds: 1));
          final image = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byType(RawImage),
          );
          final error = find.descendant(
            of: find.byType(MultiImage),
            matching: find.byIcon(Icons.error_outline_outlined),
          );
          expect(image, findsOneWidget);
          expect(error, findsNothing);
        },
      );
    },
  );
}

Future<void> _delayAndPump(
  final WidgetTester tester,
  final Duration duration,
) async {
  await Future.delayed(duration);
  await tester.pump();
}

Future<Widget> _buildMultiImageWidgetHolder(
  final List<String> imageList,
) async {
  final getIt = GetIt.instance;
  //ignore_for_file: cascade_invocations
  getIt.registerSingletonAsync(() => HiveClient.create<ImageInfo>(kImageInfoBox), instanceName: kImageInfoBox);
  getIt.registerLazySingleton(() => ImageInfoService(getIt(instanceName: kImageInfoBox)));
  getIt.registerSingleton(DefaultCacheManager());
  getIt.registerFactory(() => MultiImageViewModel(getIt(), getIt()));
  await getIt.allReady();

  return MaterialApp(
    theme: FlexThemeData.light(
      useMaterial3: true,
      colors: FlexColor.aquaBlue.light,
      surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
      blendLevel: 10,
      appBarElevation: 0.5,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    ),
    home: Container(
      height: 200,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            //TODO this will break this test, needs to have the images added to the hive box and this should take imageIds
            child: MultiImage(
              imageIds: BuiltList.of(
                imageList,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
