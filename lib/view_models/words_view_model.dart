import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_aac/api/models/word_base.dart';
import 'package:simple_aac/ui/dashboard/related_words_widget.dart';

import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../services/word_base_service.dart';

class WordsViewModel {
  WordsViewModel(this.wordService);

  final WordBaseService wordService;

  late final WordSubType wordSubType;

  final wordsOfType = BehaviorSubject<BuiltList<WordBase>>();

  void init(WordSubType wordSubType) {
    this.wordSubType = wordSubType;
    _addWords(wordSubType);
    addWordsOfTypeListener(wordSubType);
  }

  Future<BuiltList<Word>> getWordsForIds(
    BuiltList<String> wordIds,
  ) async {
    return wordService.getWordsForIds(wordIds);
  }

  void addWordsOfTypeListener(WordSubType wordSubType) {
    wordService.addListener(
      _getWordListCallBackWrapper(wordSubType),
    );
  }

  void removeWordsOfTypeListener(WordSubType wordSubType) {
    wordService.removeListener(
      _getWordListCallBackWrapper(wordSubType),
    );
  }

  Future<void> _addWords(WordSubType wordSubType) async {
    final words = await wordService.getAllForType(wordSubType);
    wordsOfType.add(words);
  }

  Future<BuiltList<WordBase>> getWordsOfType(
    WordSubType wordSubType,
  ) async {
    return wordService.getAllForType(wordSubType);
  }

  WordListCallBack _getWordListCallBackWrapper(WordSubType wordSubType) {
    return (_) {
      _addWords(wordSubType);
    };
  }

  void dispose() {
    removeWordsOfTypeListener(wordSubType);
  }
}
