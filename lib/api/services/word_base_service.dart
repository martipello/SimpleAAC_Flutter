import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../hive_client.dart';
import '../models/word_base.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'language_service.dart';

typedef WordBaseListCallBack = void Function<T extends WordBase>(BuiltList<T> wordBase);

class WordBaseService {
  WordBaseService(
    this.hiveClient,
    this.languageService,
  );

  final HiveClient hiveClient;
  final LanguageService languageService;

  Future<void> put<T extends WordBase>(
    final T word,
  ) {
    return hiveClient.put(
      word.id,
      word,
    );
  }

  Future<void> putAll<T extends WordBase>(
    final BuiltList<T> words,
  ) async {
    for (var wordBase in words) {
      await hiveClient.put(
        wordBase.id,
        wordBase,
      );
    }
  }

  Future<void> delete<T extends WordBase>(final T word) {
    return hiveClient.delete(word.id);
  }

  Future<T?> get<T extends WordBase>(final String wordBaseId) {
    return hiveClient.get<T>(wordBaseId);
  }

  Future<BuiltList<T>> getForIds<T extends WordBase>(final BuiltList<String> wordIds) {
    return _getForCurrentLanguage(wordIds);
  }

  Future<BuiltList<T>> getAll<T extends WordBase>() async {
    return _getForCurrentLanguage(BuiltList());
  }

  //DO NOT USE THIS METHOD DIRECTLY
  Future<BuiltList<T>> _getForCurrentLanguage<T extends WordBase>(
    final BuiltList<String> wordIds,
  ) async {
    final currentLanguage = await languageService.getCurrentLanguage();
    final words = wordIds.isNotEmpty ? hiveClient.getAllForKeys<T>(wordIds) : hiveClient.getAll<T>();
    return words
        .where(
          (final word) => word.languageIds.contains(currentLanguage.id),
        )
        .toBuiltList();
  }

  Future<BuiltList<T>> getAllForType<T extends WordBase>(final WordType wordType) async {
    final allWords = await getAll<T>();
    return allWords.where((final w) => w.type == wordType).toBuiltList();
  }

  Future<BuiltList<T>> getAllForSubType<T extends WordBase>(final WordSubType wordSubType) async {
    final allWords = await getAll<T>();
    return allWords.where((final w) => w.subType == wordSubType).toBuiltList();
  }

  void addListener<T extends WordBase>(final AsyncCallback callback) {
    return hiveClient.addListener(callback);
  }

  void removeListener<T extends WordBase>(final AsyncCallback callback) {
    return hiveClient.addListener(callback);
  }

  void dispose() {
    hiveClient.dispose();
  }
}
