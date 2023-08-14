import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../hive_client.dart';
import '../models/language.dart';
import '../models/word.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'word_base_service.dart';

const kWordBox = 'word_box';
typedef WordListCallBack = void Function<T extends Word>(BuiltList<T> word);
typedef WordIDListCallBack = void Function(BuiltList<String> word);

class WordService {
  WordService(
    this.hiveClient,
    this.wordBaseService,
  );

  final HiveClient hiveClient;
  final WordBaseService wordBaseService;

  Future<void> put(final Word word) {
    return wordBaseService.put(word);
  }

  Future<void> putAll(final BuiltList<Word> words) async {
    for (var word in words) {
      await put(word);
    }
  }

  Future<void> delete(final Word word) {
    return wordBaseService.delete(word);
  }

  Future<void> deleteAll() async {
    await hiveClient.deleteAll();
  }

  Future<Word?> get(final String wordId) {
    return wordBaseService.get(wordId);
  }

  Future<BuiltList<Word>> getForIds(final BuiltList<String> wordIds) {
    return wordBaseService.getForIds(wordIds);
  }

  Future<BuiltList<Word>> getAll() async {
    return wordBaseService.getAll();
  }

  Future<BuiltList<Word>> getAllForType(final WordType wordType) async {
    return wordBaseService.getAllForType(wordType);
  }

  Future<BuiltList<Word>> getAllForSubType(final WordSubType wordSubType) async {
    return wordBaseService.getAllForSubType(wordSubType);
  }

  Future<BuiltList<Word>> getExtraRelatedWords(final Word word) async {
    return getForIds(word.extraRelatedWordIds);
  }

  Future<BuiltList<Word>> getRelatedWords(final Word word) async {
    return getExtraRelatedWords(word);
  }

  Future<BuiltList<T>> getAllForLanguage<T extends Word>(
      final Language language,
      ) async {
    final words = hiveClient.getAll<T>();
    return words
        .where(
          (final word) => word.languageIds.contains(language.id),
    )
        .toBuiltList();
  }

  void addListener(final AsyncCallback callBack) {
    return wordBaseService.addListener(callBack);
  }

  void removeListener(final AsyncCallback callBack) {
    return wordBaseService.removeListener(callBack);
  }

  void dispose() {
    hiveClient.dispose();
  }
}
