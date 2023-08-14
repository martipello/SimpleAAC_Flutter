import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import '../hive_client.dart';
import '../models/language.dart';
import 'shared_preferences_service.dart';

const kLanguageBox = 'language_box';

typedef LanguageCallBack = void Function(Language language);

class LanguageService {
  LanguageService(
    this.hiveClient,
    this.sharedPreferencesService,
  );

  final HiveClient hiveClient;
  final SharedPreferencesService sharedPreferencesService;

  String get currentLanguageId => sharedPreferencesService.currentLanguageId;

  Future<void> put(final Language language) {
    return hiveClient.put(
      language.id,
      language,
    );
  }

  Future<void> putAll(final BuiltList<Language> languages) async {
    for (var language in languages) {
      await hiveClient.put(
        language.id,
        language,
      );
    }
  }

  Future<void> delete(final Language language) {
    return hiveClient.delete(language.id);
  }

  Future<void> deleteAll() async {
    await hiveClient.deleteAll();
  }

  Future<Language> getCurrentLanguage() async {
    final language = await hiveClient.get<Language>(currentLanguageId);
    return language!;
  }

  void setCurrentLanguage(final Language language) {
    sharedPreferencesService.setLanguageId(language.id);
  }

  Future<Language?> get(final String languageId) {
    return hiveClient.get(languageId);
  }

  Future<BuiltList<Language>> getAll() async {
    return hiveClient.getAll();
  }

  void addListener(final LanguageCallBack callBack) {
    sharedPreferencesService.addListener(
      _getLanguageCallbackWrapper(callBack),
    );
  }

  void removeListener(final LanguageCallBack callBack) {
    sharedPreferencesService.removeListener(
      _getLanguageCallbackWrapper(callBack),
    );
  }

  AsyncCallback _getLanguageCallbackWrapper(
    final LanguageCallBack callBack,
  ) {
    return () async {
      final currentLanguage = await getCurrentLanguage();
      callBack.call(currentLanguage);
    };
  }

  void dispose() {
    hiveClient.dispose();
  }
}
