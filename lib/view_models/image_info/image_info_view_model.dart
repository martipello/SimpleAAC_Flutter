import 'package:built_collection/built_collection.dart';

import '../../api/models/sentence.dart';
import '../../api/models/word.dart';
import '../../api/models/word_base.dart';
import '../../api/models/word_group.dart';
import '../../api/services/image_info_service.dart';
import '../../api/services/word_service.dart';

class ImageInfoViewModel {
  ImageInfoViewModel(
    this.imageInfoService,
    this.wordService,
  );

  final ImageInfoService imageInfoService;
  final WordService wordService;

  Future<BuiltList<String>> getImageIds(final WordBase wordBase) async {
    if (wordBase is Word) {
      return [wordBase.imageId].toBuiltList();
    } else if (wordBase is Sentence) {
      return _getImageIdsForSentence(wordBase);
    } else if (wordBase is WordGroup) {
      return _getImageIdsForWordGroup(wordBase);
    } else {
      return BuiltList<String>();
    }
  }

  Future<BuiltList<String>> _getImageIdsForSentence(
    final Sentence wordBase,
  ) async {
    var imageIds = BuiltList<String>();
    final words = await wordService.getForIds(wordBase.wordIds);
    imageIds = imageIds.rebuild(
      (final ids) => ids.replace(
        words.map(
          (final word) => word.imageId,
        ),
      ),
    );
    return imageIds;
  }

  Future<BuiltList<String>> _getImageIdsForWordGroup(
    final WordGroup wordBase,
  ) async {
    var imageIds = BuiltList<String>();
    final words = await wordService.getForIds(wordBase.wordIds);
    imageIds = imageIds.rebuild(
      (final ids) => ids.replace(
        words.map(
          (final word) => word.imageId,
        ),
      ),
    );
    return imageIds;
  }
}
