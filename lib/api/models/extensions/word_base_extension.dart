import 'package:simple_aac/api/models/word_base.dart';

extension WordExtension on WordBase {
  String getHeroTag(String suffix) {
    return '$suffix$id';
  }
}