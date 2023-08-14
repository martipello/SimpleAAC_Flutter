import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../hive_client.dart';
import '../models/word_group.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'word_base_service.dart';

const kWordGroupBox = 'word_group_box';
typedef WordGroupListCallBack = void Function<T extends WordGroup>(BuiltList<T> wordGroup);

class WordGroupService {
  WordGroupService(
    this.hiveClient,
    this.wordBaseService,
  );

  final HiveClient hiveClient;
  final WordBaseService wordBaseService;

  Future<void> put(final WordGroup wordGroup) {
    return wordBaseService.put(wordGroup);
  }

  Future<void> putAll(final BuiltList<WordGroup> wordGroups) async {
    for (var wordGroup in wordGroups) {
      return put(wordGroup);
    }
  }

  Future<void> delete(final WordGroup wordGroup) {
    return wordBaseService.delete(wordGroup);
  }

  Future<void> deleteAll() async {
    await hiveClient.deleteAll();
  }

  Future<WordGroup?> get(final String wordGroupId) {
    return wordBaseService.get(wordGroupId);
  }

  Future<BuiltList<WordGroup>> getForIds(final BuiltList<String> wordGroupIds) {
    return wordBaseService.getForIds(wordGroupIds);
  }

  Future<BuiltList<WordGroup>> getAll() async {
    return wordBaseService.getAll();
  }

  Future<BuiltList<WordGroup>> getAllForType(final WordType wordType) async {
    return wordBaseService.getAllForType(wordType);
  }

  Future<BuiltList<WordGroup>> getAllForSubType(final WordSubType wordSubType) async {
    return wordBaseService.getAllForSubType(wordSubType);
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
