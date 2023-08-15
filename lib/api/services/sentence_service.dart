import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../hive_client.dart';
import '../models/sentence.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'word_base_service.dart';

const kSentenceBox = 'sentence_box';
typedef SentenceListCallBack = void Function<T extends Sentence>(BuiltList<T> sentence);

class SentenceService {
  SentenceService(
    this.hiveClient,
    this.wordBaseService,
  );

  final HiveClient hiveClient;
  final WordBaseService wordBaseService;

  Future<void> put(final Sentence sentence) {
    return wordBaseService.put(sentence);
  }

  Future<void> putAll(final BuiltList<Sentence> sentences) async {
    for (var sentence in sentences) {
      await put(sentence);
    }
  }

  Future<void> delete(final Sentence sentence) {
    return wordBaseService.delete(sentence);
  }

  Future<void> deleteAll() async {
    await hiveClient.deleteAll();
  }

  Future<Sentence?> get(final String sentenceId) {
    return wordBaseService.get(sentenceId);
  }

  Future<BuiltList<Sentence>> getForIds(final BuiltList<String> wordIds) {
    return wordBaseService.getForIds(wordIds);
  }

  Future<BuiltList<Sentence>> getAll() async {
    return wordBaseService.getAll();
  }

  Future<BuiltList<Sentence>> getAllForType(final WordType wordType) async {
    return wordBaseService.getAllForType(wordType);
  }

  Future<BuiltList<Sentence>> getAllForSubType(final WordSubType wordSubType) async {
    return wordBaseService.getAllForSubType(wordSubType);
  }

  Future<BuiltList<Sentence>> getExtraRelatedWords(final Sentence word) async {
    //TODO magic LLM method for getting "predictions"
    return getForIds(word.extraRelatedWordIds);
  }

  Future<BuiltList<Sentence>> getRelatedWords(final Sentence word) async {
    return getExtraRelatedWords(word);
  }

  void addListener(final AsyncCallback callBack) {
    return wordBaseService.addListener(callBack);
  }

  void removeListener(final AsyncCallback callBack) {
    return wordBaseService.removeListener(callBack);
  }

}
