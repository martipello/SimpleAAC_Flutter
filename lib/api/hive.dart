import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../dependency_injection_container.dart' as di;
import 'models/image_info.dart';
import 'models/image_info_response.dart';
import 'services/image_info_service.dart';
import 'services/language_service.dart';
import 'services/sentence_service.dart';
import 'services/word_group_service.dart';
import 'services/word_service.dart';
import 'models/language.dart';
import 'models/languages_response.dart';
import 'models/sentence.dart';
import 'models/sentences_response.dart';
import 'models/theme_service_hive_adapters.dart';
import 'models/word.dart';
import 'models/word_group.dart';
import 'models/word_groups_response.dart';
import 'models/word_sub_type.dart';
import 'models/word_type.dart';
import 'models/words_response.dart';

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
    ..registerAdapter<ImageInfo>(ImageInfoAdapter())
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
  final imageInfoService = di.getIt.get<ImageInfoService>();
  final wordService = di.getIt.get<WordService>(instanceName: kWordBox);
  final sentenceService = di.getIt.get<SentenceService>(instanceName: kSentenceBox);
  final wordGroupService = di.getIt.get<WordGroupService>(instanceName: kWordGroupBox);

  await languageService.deleteAll();
  await imageInfoService.deleteAll();
  await wordService.deleteAll();
  await sentenceService.deleteAll();
  await wordGroupService.deleteAll();

  final initialImageInfoData = await rootBundle.loadString(
    'assets/json/initial_image_info_data.json',
  );
  final initialWordData = await rootBundle.loadString(
    'assets/json/initial_word_data.json',
  );
  final initialSentenceData = await rootBundle.loadString(
    'assets/json/initial_sentence_data.json',
  );
  final initialWordGroupData = await rootBundle.loadString(
    'assets/json/initial_word_group_data.json',
  );
  final initialLanguageData = await rootBundle.loadString(
    'assets/json/initial_language_data.json',
  );

  final initialImageInfoDataJson = await jsonDecode(initialImageInfoData);

  final initialLanguageDataJson = await jsonDecode(initialLanguageData);
  final initialWordDataJson = await jsonDecode(initialWordData);
  final initialSentencesDataJson = await jsonDecode(initialSentenceData);
  final initialWordGroupsDataJson = await jsonDecode(initialWordGroupData);

  final imageInfos = ImageInfoResponse.fromJson(initialImageInfoDataJson).imageInfos;
  final languages = LanguagesResponse.fromJson(initialLanguageDataJson).languages;
  final words = WordsResponse.fromJson(initialWordDataJson).words;
  final sentences = SentencesResponse.fromJson(initialSentencesDataJson).sentences;
  final wordGroups = WordGroupsResponse.fromJson(initialWordGroupsDataJson).wordGroups;


  await imageInfoService.putAll(imageInfos);
  await languageService.putAll(languages);
  await wordService.putAll(words);
  await sentenceService.putAll(sentences);
  await wordGroupService.putAll(wordGroups);
}

