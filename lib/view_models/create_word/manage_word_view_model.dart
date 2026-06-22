import 'package:rxdart/rxdart.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../services/word_service.dart';

class ManageWordViewModel {
  ManageWordViewModel(this.wordService);

  final WordService wordService;

  final wordStream = BehaviorSubject<Word?>();
  Word? _originalWord;

  void setWord(Word? word) {
    _originalWord = word;
    wordStream.add(
      word ??
          Word(
            wordId: DateTime.now().millisecondsSinceEpoch.toString(),
            text: '',
            type: WordType.things,
            subType: WordSubType.people,
            imagePath: null,
            isCoreVocabulary: false,
          ),
    );
  }

  void setWordSubType(WordSubType? subType) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(word.copyWith(subType: subType ?? word.subType));
    }
  }

  void setWordType(WordType? type) {
    final word = wordStream.valueOrNull;
    if (word == null || type == null) return;
    final subTypes = type.getSubTypes();
    final subType = subTypes.isNotEmpty ? subTypes.first : word.subType;
    wordStream.add(word.copyWith(type: type, subType: subType));
  }

  void setWordText(String text) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(word.copyWith(text: text));
    }
  }

  void setPhoneticOverride(String? phonetic) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(word.copyWith(phoneticOverride: phonetic));
    }
  }

  void setImagePath(String path) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(word.copyWith(imagePath: path));
    }
  }

  void setExtraRelatedWords(List<String> relatedWordIds) {
    final word = wordStream.valueOrNull;
    if (word != null) {
      wordStream.add(word.copyWith(extraRelatedWordIds: relatedWordIds));
    }
  }

  Stream<bool> get isValid => wordStream.map(
        (word) => word != null && word.text.trim().isNotEmpty && (word.imagePath?.isNotEmpty ?? false),
      );

  Stream<List<Word>> get relatedWords =>
      wordStream.whereType<Word>().switchMap(
            (word) => wordService.getRelatedWords(word).asStream(),
          );

  Future<void> saveWord() async {
    final word = wordStream.valueOrNull;
    if (word != null) {
      await wordService.saveCustomWord(word, original: _originalWord);
    }
  }

  void dispose() => wordStream.close();
}
