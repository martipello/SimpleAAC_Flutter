import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../api/hive_client.dart';
import '../api/models/language.dart';
import 'shared_preferences_service.dart';

const kLanguageBox = 'language';

typedef LanguageCallBack = void Function(Language language);

class LanguageService {
  LanguageService(
    this.hiveClient,
    this.sharedPreferencesService,
  );

  final HiveClient hiveClient;
  final SharedPreferencesService sharedPreferencesService;

  String currentLanguageId() {
    return sharedPreferencesService.currentLanguageId;
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

  Future<Language> getCurrentLanguage() async {
    final languageId = sharedPreferencesService.currentLanguageId;
    final language = await hiveClient.get<Language>(languageId);
    return language!;
  }

  void setCurrentLanguage(Language language) {
    sharedPreferencesService.setLanguageId(language.id);
  }

  Future<Language?> get(String languageId) {
    return hiveClient.get(languageId);
  }

  Future<BuiltList<Language>> getAll() async {
    return hiveClient.getAll();
  }

  void addListener(LanguageCallBack callBack) {
    sharedPreferencesService.addListener(
      _getLanguageCallbackWrapper(callBack),
    );
  }

  void removeListener(LanguageCallBack callBack) {
    sharedPreferencesService.removeListener(
      _getLanguageCallbackWrapper(callBack),
    );
  }

  AsyncCallback _getLanguageCallbackWrapper(LanguageCallBack callBack) {
    return () async {
      final currentLanguage = await getCurrentLanguage();
      callBack.call(currentLanguage);
    };
  }

  void dispose() {
    hiveClient.dispose();
  }
}
