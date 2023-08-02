import 'word_base.dart';

part 'sentence.g.dart';

class Sentence extends WordBase {

  final List<Word> words;

  final List<String> extraRelatedWordIds;
}
