import 'package:flutter_test/flutter_test.dart';
import 'package:simple_aac/ui/shared_widgets/view_model/multi_image_view_model.dart';
import 'package:built_collection/built_collection.dart';

void main() {
  final imageList = BuiltList.of([
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
    'assets/images/simple_aac.png',
  ]);

  final multiImageViewModel = MultiImageViewModel();

  test(
    'One image to load them all! load one load all',
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      multiImageViewModel.fourImages.listen(
        (images) {
          expect(images.length, 4);
        },
      );
      multiImageViewModel.requestFourImages(imageList);
      await Future.delayed(Duration(seconds: 10));
    },
  );
}
