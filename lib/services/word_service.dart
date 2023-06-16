import 'dart:async';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../api/hive_client.dart';
import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../api/models/word_type.dart';

const kWordBox = 'words';

class WordService {
  WordService(this.hiveClient);

  final HiveClient hiveClient;

  Future<void> put(Word word) {
    return hiveClient.put<Word>(
      word.wordId,
      word,
    );
  }

  Future<void> putAll(BuiltList<Word> words) async {
    for(var word in words) {
      await hiveClient.put<Word>(
        word.wordId,
        word,
      );
    }
  }

  Future<void> delete(Word word) {
    return hiveClient.delete(word.wordId);
  }

  Future<Word?> get(String wordId) {
    return hiveClient.get<Word?>(wordId);
  }

  Future<BuiltList<Word>> getAll() async {
    return hiveClient.getAll<Word>();
  }

  Future<BuiltList<Word>> getAllForKeys(BuiltList<String> keys) async {
    return hiveClient.getAllForKeys<Word>(keys);
  }

  Future<BuiltList<Word>> getAllForType(WordSubType wordSubType) async {
    return hiveClient.getAll<Word>().where((w) => w.subType == wordSubType).toBuiltList();
  }

  Future<BuiltList<Word>> getRelatedWords(Word word) async {
    final extraRelatedWords = await hiveClient.getAllForKeys<Word>(word.extraRelatedWordIds);
    final relatedWords = await hiveClient.getAllForKeys<Word>(word.extraRelatedWordIds);
    return <Word>{...extraRelatedWords, ...relatedWords}.toBuiltList();
  }

  void addListener(AsyncCallback voidCallback) {
    hiveClient.addListener(voidCallback);
  }

  void removeListener(AsyncCallback voidCallback) {
    hiveClient.removeListener(voidCallback);
  }
}
