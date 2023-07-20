import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/services.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'models/sentence.dart';
import 'models/sentences_response.dart';
import 'models/word_groups_response.dart';

import '../dependency_injection_container.dart' as di;
import '../services/language_service.dart';
import 'models/language.dart';
import 'models/languages_response.dart';
import 'models/theme_service_hive_adapters.dart';
import 'models/word.dart';
import 'models/word_group.dart';
import 'models/word_sub_type.dart';
import 'models/word_type.dart';

Future<void> initHive(
  final Directory appDocumentDir,
) async {
  Hive..init(appDocumentDir.path)
    ..registerAdapter<Word>(WordAdapter())
    ..registerAdapter<Sentence>(SentenceAdapter())
    ..registerAdapter<WordGroup>(WordGroupAdapter())
    ..registerAdapter<Language>(LanguageAdapter())
    ..registerAdapter<WordSubType>(WordSubTypeAdapter())
    ..registerAdapter<WordType>(WordTypeAdapter())
    ..registerAdapter(ThemeModeAdapter())
    ..registerAdapter(ColorAdapter())
    ..registerAdapter(FlexSchemeAdapter())
    ..registerAdapter(FlexSurfaceModeAdapter())
    ..registerAdapter(FlexInputBorderTypeAdapter())
    ..registerAdapter(FlexTabBarStyleAdapter())
    ..registerAdapter(FlexAppBarStyleAdapter())
    ..registerAdapter(FlexSystemNavBarStyleAdapter())
    ..registerAdapter(FlexSchemeColorAdapter())
    ..registerAdapter(NavigationDestinationLabelBehaviorAdapter())
    ..registerAdapter(NavigationRailLabelTypeAdapter())
    ..registerAdapter(FlexSliderIndicatorTypeAdapter())
    ..registerAdapter(ShowValueIndicatorAdapter())
    ..registerAdapter(TabBarIndicatorSizeAdapter())
    ..registerAdapter(AdaptiveThemeAdapter());
}

Future<void> populateInitialData() async {
  final languageService = di.getIt.get<LanguageService>();
  final initialWordData = await rootBundle.loadString(
    'assets/json/initial_word_data.json',
  );
  final initialSentenceData = await rootBundle.loadString(
    'assets/json/initial_sentence_data.json',
  );
  final initialWordGroupData = await rootBundle.loadString(
    'assets/json/initial_word_group_data.json',
  );

  final initialWordDataJson = await jsonDecode(initialWordData);
  final initialSentences = await jsonDecode(initialSentenceData);
  final initialWordGroup = await jsonDecode(initialWordGroupData);

  final languages = LanguagesResponse.fromJson(initialWordDataJson).languages;
  final sentences = SentencesResponse.fromJson(initialSentences).sentences;
  final wordGroups = WordGroupsResponse.fromJson(initialWordGroup).wordGroups;

  final rebuiltFirstLanguage = _replaceFirstLanguagesSentencesAndWordGroups(
    languages,
    sentences,
    wordGroups,
  );

  await languageService.putAll(rebuiltFirstLanguage);
}

BuiltList<Language> _replaceFirstLanguagesSentencesAndWordGroups(
  final BuiltList<Language> languages,
  final BuiltList<Sentence> sentences,
  final BuiltList<WordGroup> wordGroups,
) {
  final languageWithSentenceAndWordGroupData = languages.first.rebuild(
    (final l) => l
      ..sentences.replace(sentences)
      ..wordGroups.replace(wordGroups),
  );

  final rebuiltFirstLanguage = BuiltList<Language>.of([
    languageWithSentenceAndWordGroupData,
    ...languages.skip(1),
  ]);
  return rebuiltFirstLanguage;
}
