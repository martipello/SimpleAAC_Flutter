import '../word.dart';

extension WordExtension on Word {
  String getHeroTag(String suffix) {
    return '$suffix$wordId';
  }
}