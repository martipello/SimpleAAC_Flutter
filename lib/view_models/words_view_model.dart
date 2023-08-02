import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';
import '../api/models/word_base.dart';
import '../ui/dashboard/related_words_widget.dart';

import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../services/word_service.dart';

class WordsViewModel {
  WordsViewModel(this.wordService);

  final WordBaseService wordService;

  late final WordSubType wordSubType;

  final wordsOfType = BehaviorSubject<BuiltList<WordBase>>();

  void init(final WordSubType wordSubType) {
    this.wordSubType = wordSubType;
    _addWords(wordSubType);
    addWordsOfTypeListener(wordSubType);
  }

  Future<BuiltList<Word>> getWordsForIds(
    final BuiltList<String> wordIds,
  ) async {
    return wordService.getWordsForIds(wordIds);
  }

  void addWordsOfTypeListener(final WordSubType wordSubType) {
    wordService.addListener(
      _getWordListCallBackWrapper(wordSubType),
    );
  }

  void removeWordsOfTypeListener(final WordSubType wordSubType) {
    wordService.removeListener(
      _getWordListCallBackWrapper(wordSubType),
    );
  }

  Future<void> _addWords(final WordSubType wordSubType) async {
    final words = await wordService.getAllForType(wordSubType);
    wordsOfType.add(words);
  }

  Future<BuiltList<WordBase>> getWordsOfType(
    final WordSubType wordSubType,
  ) async {
    return wordService.getAllForType(wordSubType);
  }

  WordListCallBack _getWordListCallBackWrapper(final WordSubType wordSubType) {
    return (final _) {
      _addWords(wordSubType);
    };
  }

  void dispose() {
    removeWordsOfTypeListener(wordSubType);
  }
}
