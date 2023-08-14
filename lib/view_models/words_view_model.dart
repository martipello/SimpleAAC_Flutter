import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/sentence.dart';
import '../api/models/word.dart';
import '../api/models/word_base.dart';
import '../api/models/word_group.dart';
import '../api/models/word_sub_type.dart';
import '../api/services/sentence_service.dart';
import '../api/services/word_group_service.dart';
import '../api/services/word_service.dart';
import '../extensions/iterable_extension.dart';
import '../utils/stream_helper.dart';

class WordsViewModel {
  WordsViewModel(
    this.wordService,
    this.sentenceService,
    this.wordGroupService,
  );

  final WordService wordService;
  final SentenceService sentenceService;
  final WordGroupService wordGroupService;

  late final WordSubType wordSubType;

  final compositeSubscription = CompositeSubscription();

  final words = BehaviorSubject<BuiltList<Word>>();
  final sentences = BehaviorSubject<BuiltList<Sentence>>();
  final wordGroups = BehaviorSubject<BuiltList<WordGroup>>();

  late final allWords = _allWords ??= _makeCombineAllWords();

  Stream<BuiltList<WordBase>>? _allWords;

  Stream<BuiltList<WordBase>> _makeCombineAllWords(){
    return combine3<BuiltList<Word>, BuiltList<Sentence>, BuiltList<WordGroup>>(
      words,
      sentences,
      wordGroups,
    ).map((final event) {
      return [
        ...event.item1,
        ...event.item2,
        ...event.item3,
      ].toBuiltList();
    }).publishValue()
      ..connect().addTo(compositeSubscription);
  }

  void init(final WordSubType wordSubType) {
    this.wordSubType = wordSubType;
    _refreshWords(wordSubType);
    _refreshWordGroups(wordSubType);
    _refreshSentences(wordSubType);
    addGetAllWordsForSubTypeListener(wordSubType);
    addGetAllWordGroupsForSubTypeListener(wordSubType);
    addGetAllSentencesForSubTypeListener(wordSubType);
  }

  Future<BuiltList<Word>> getWordsForIds(
    final BuiltList<String> wordIds,
  ) async {
    return wordService.getForIds(wordIds);
  }

  void addGetAllWordsForSubTypeListener(final WordSubType wordSubType) {
    wordService.addListener(
      _getWordListCallBackWrapper(wordSubType),
    );
  }

  void removeGetAllWordsForSubTypeListener(final WordSubType wordSubType) {
    wordService.removeListener(
      _getWordListCallBackWrapper(wordSubType),
    );
  }

  void addGetAllWordGroupsForSubTypeListener(final WordSubType wordSubType) {
    wordGroupService.addListener(
      _getWordGroupListCallBackWrapper(wordSubType),
    );
  }

  void removeGetAllWordGroupsForSubTypeListener(final WordSubType wordSubType) {
    wordGroupService.removeListener(
      _getWordGroupListCallBackWrapper(wordSubType),
    );
  }

  void addGetAllSentencesForSubTypeListener(final WordSubType wordSubType) {
    sentenceService.addListener(
      _getSentenceListCallBackWrapper(wordSubType),
    );
  }

  void removeGetAllSentencesForSubTypeListener(final WordSubType wordSubType) {
    sentenceService.removeListener(
      _getSentenceListCallBackWrapper(wordSubType),
    );
  }

  AsyncCallback _getWordListCallBackWrapper(final WordSubType wordSubType) {
    return () async {
      await _refreshWords(wordSubType);
    };
  }

  AsyncCallback _getWordGroupListCallBackWrapper(final WordSubType wordSubType) {
    return () async {
      await _refreshWordGroups(wordSubType);
    };
  }

  AsyncCallback _getSentenceListCallBackWrapper(final WordSubType wordSubType) {
    return () async {
      await _refreshSentences(wordSubType);
    };
  }

  Future<void> _refreshWords(final WordSubType wordSubType) async {
    final words = await wordService.getAllForSubType(wordSubType);
    this.words.add(words);
  }

  Future<void> _refreshWordGroups(final WordSubType wordSubType) async {
    final wordGroups = await wordGroupService.getAllForSubType(wordSubType);
    this.wordGroups.add(wordGroups);
  }

  Future<void> _refreshSentences(final WordSubType wordSubType) async {
    final sentences = await sentenceService.getAllForSubType(wordSubType);
    this.sentences.add(sentences);
  }

  void dispose() {
    removeGetAllWordsForSubTypeListener(wordSubType);
    removeGetAllWordGroupsForSubTypeListener(wordSubType);
    removeGetAllSentencesForSubTypeListener(wordSubType);
    words.close();
    sentences.close();
    wordGroups.close();
    compositeSubscription.dispose();
  }
}
