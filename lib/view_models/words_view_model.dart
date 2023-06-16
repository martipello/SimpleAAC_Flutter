import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../services/word_service.dart';

class WordsViewModel {
  WordsViewModel(this.wordService);

  final WordService wordService;

  late final WordSubType wordSubType;

  final wordsOfType = BehaviorSubject<BuiltList<Word>>();

  void init(WordSubType wordSubType){
    this.wordSubType = wordSubType;
    _addWords(wordSubType);
    addWordsOfTypeListener(wordSubType);
  }

  Future<BuiltList<Word>> getWordsForIds(
    BuiltList<String> wordIds,
  ) async {
    return wordService.getAllForKeys(wordIds);
  }

  void addWordsOfTypeListener(WordSubType wordSubType) {
    wordService.addListener(listenerCallBack(wordSubType));
  }

  void removeWordsOfTypeListener(WordSubType wordSubType) {
    wordService.removeListener(listenerCallBack(wordSubType));
  }

  AsyncCallback listenerCallBack(WordSubType wordSubType) {
    return () async {
      await _addWords(wordSubType);
    };
  }

  Future<void> _addWords(WordSubType wordSubType) async {
    final words = await wordService.getAllForType(wordSubType);
    wordsOfType.add(words);
  }

  Future<BuiltList<Word>> getWordsOfType(
    WordSubType wordSubType,
  ) async {
    return wordService.getAllForType(wordSubType);
  }

  void dispose(){
    removeWordsOfTypeListener(wordSubType);
  }
}
