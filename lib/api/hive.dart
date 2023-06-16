import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../dependency_injection_container.dart' as di;
import '../services/word_service.dart';
import 'models/theme_service_hive_adapters.dart';
import 'models/word.dart';
import 'models/word_response.dart';
import 'models/word_sub_type.dart';
import 'models/word_type.dart';

Future<void> initHive(
  Directory appDocumentDir,
) async {
  Hive.init(appDocumentDir.path);
  Hive
    ..registerAdapter<Word>(WordAdapter())
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
  final wordService = di.getIt.get<WordService>();
  final initialWordData = await rootBundle.loadString(
    'assets/json/initial_word_data.json',
  );
  final initialWordDataJson = await jsonDecode(initialWordData);
  wordService.putAll(
    WordResponse.fromJson(initialWordDataJson).words,
  );
}
