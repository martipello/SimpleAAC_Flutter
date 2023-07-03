import 'package:simple_aac/api/models/word.dart';
import 'package:simple_aac/api/models/word_base.dart';
import 'package:built_collection/built_collection.dart';

import '../sentence.dart';

extension WordExtension on WordBase {
  String getHeroTag(String suffix) {
    return '$suffix$id';
  }

  BuiltList<String> getImageList() {
    final wordBase = this;
    if (wordBase is Word) {
      return wordBase.imageList;
    } else if (wordBase is Sentence) {
      return BuiltList<String>.from(wordBase.words.map((word) => word.imageList.first));
    }
    return BuiltList<String>();
  }
}
