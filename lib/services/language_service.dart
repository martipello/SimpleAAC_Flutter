import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../api/hive_client.dart';
import '../api/models/language.dart';
import 'shared_preferences_service.dart';

const kLanguageBox = 'language';

class LanguageService {
  LanguageService(
    this.hiveClient,
    this.sharedPreferencesService,
  );

  final HiveClient hiveClient;
  final SharedPreferencesService sharedPreferencesService;

  String currentLanguageId() {
    return sharedPreferencesService.languageId();
  }

  Future<void> put(Language language) {
    return hiveClient.put(
      language.id,
      language,
    );
  }

  Future<void> putAll(BuiltList<Language> languages) async {
    for (var language in languages) {
      await hiveClient.put(
        language.id,
        language,
      );
    }
  }

  Future<void> delete(Language language) {
    return hiveClient.delete(language.id);
  }

  Future<Language?> getCurrentLanguage() {
    final languageId = sharedPreferencesService.languageId();
    return hiveClient.get(languageId);
  }

  Future<Language?> get(String languageId) {
    return hiveClient.get(languageId);
  }

  Future<BuiltList<Language>> getAll() async {
    return hiveClient.getAll();
  }

  void addListener(AsyncCallback voidCallback) {
    hiveClient.addListener(voidCallback);
  }

  void removeListener(AsyncCallback voidCallback) {
    hiveClient.removeListener(voidCallback);
  }
}
