import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/models/image_info.dart';
import 'api/services/image_info_service.dart';
import 'api/models/sentence.dart';
import 'api/models/word.dart';
import 'api/models/word_group.dart';
import 'api/services/sentence_service.dart';
import 'api/services/word_base_service.dart';
import 'api/services/word_group_service.dart';
import 'ui/shared_widgets/view_model/multi_image_view_model.dart';
import 'ui/shared_widgets/word_group_tile_expanded_view_model.dart';
import 'view_models/image_info/image_info_view_model.dart';
import 'view_models/language_view_model.dart';

import 'api/hive_client.dart';
import 'api/models/language.dart';
import 'api/services/language_service.dart';
import 'api/services/navigation_service.dart';
import 'api/services/shared_preferences_service.dart';
import 'api/services/theme_service.dart';
import 'api/services/word_service.dart';
import 'ui/theme/theme_controller.dart';
import 'view_models/create_word/manage_word_view_model.dart';
import 'view_models/file_picker/file_picker_view_model.dart';
import 'view_models/intro/intro_view_model.dart';
import 'view_models/selected_words_view_model.dart';
import 'view_models/theme_view_model.dart';
import 'view_models/utils/tab_bar_view_model.dart';
import 'view_models/words_view_model.dart';

final getIt = GetIt.instance;

//ignore_for_file: cascade_invocations
Future<void> init() async {
  getIt.registerLazySingletonAsync(SharedPreferences.getInstance);
  getIt.registerLazySingletonAsync(PackageInfo.fromPlatform);

  getIt.registerSingletonAsync(() => HiveClient.create<dynamic>(kThemeBox), instanceName: kThemeBox);
  getIt.registerSingletonAsync(() => HiveClient.create<Language>(kLanguageBox), instanceName: kLanguageBox);
  getIt.registerSingletonAsync(() => HiveClient.create<WordGroup>(kWordGroupBox), instanceName: kWordGroupBox);
  getIt.registerSingletonAsync(() => HiveClient.create<Sentence>(kSentenceBox), instanceName: kSentenceBox);
  getIt.registerSingletonAsync(() => HiveClient.create<Word>(kWordBox), instanceName: kWordBox);
  getIt.registerSingletonAsync(() => HiveClient.create<ImageInfo>(kImageInfoBox), instanceName: kImageInfoBox);

  await getIt.isReady<HiveClient>(instanceName: kThemeBox);
  await getIt.isReady<HiveClient>(instanceName: kImageInfoBox);
  await getIt.isReady<HiveClient>(instanceName: kLanguageBox);

  await getIt.isReady<HiveClient>(instanceName: kWordBox);
  await getIt.isReady<HiveClient>(instanceName: kSentenceBox);
  await getIt.isReady<HiveClient>(instanceName: kWordGroupBox);

  await getIt.isReady<SharedPreferences>();
  await getIt.isReady<PackageInfo>();
  // await getIt.isReady<SharedPreferences>();

  getIt.registerLazySingleton(() => LanguageService(getIt(instanceName: kLanguageBox), getIt()));
  getIt.registerLazySingleton(() => ImageInfoService(getIt(instanceName: kImageInfoBox)));

  getIt.registerLazySingleton(() => WordBaseService(getIt(instanceName: kWordBox), getIt()), instanceName: kWordBox);
  getIt.registerLazySingleton(() => WordBaseService(getIt(instanceName: kWordGroupBox), getIt()), instanceName: kWordGroupBox);
  getIt.registerLazySingleton(() => WordBaseService(getIt(instanceName: kSentenceBox), getIt()), instanceName: kSentenceBox);

  getIt.registerLazySingleton(() => WordService(getIt(instanceName: kWordBox), getIt(instanceName: kWordBox)), instanceName: kWordBox);
  getIt.registerLazySingleton(() => WordGroupService(getIt(instanceName: kWordGroupBox), getIt(instanceName: kWordGroupBox)), instanceName: kWordGroupBox);
  getIt.registerLazySingleton(() => SentenceService(getIt(instanceName: kSentenceBox), getIt(instanceName: kSentenceBox)), instanceName: kSentenceBox);

  getIt.registerLazySingleton(DefaultCacheManager.new);
  getIt.registerLazySingleton(() => SharedPreferencesService(getIt()));
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(NavigationService.new);
  getIt.registerLazySingleton(ImagePicker.new);
  getIt.registerLazySingleton(() => SelectedWordsViewModel(getIt(instanceName: kWordBox)));
  getIt.registerFactory(() => ThemeService(getIt(instanceName: kThemeBox)));
  getIt.registerFactory(() => ThemeController(getIt()));
  getIt.registerFactory(() => WordsViewModel(getIt(instanceName: kWordBox), getIt(instanceName: kSentenceBox), getIt(instanceName: kWordGroupBox)));
  getIt.registerFactory(() => LanguageViewModel(getIt(), getIt(instanceName: kWordBox)));
  getIt.registerFactory(IntroViewModel.new);
  getIt.registerFactory(TabBarViewModel.new);
  getIt.registerFactory(() => ManageWordViewModel(getIt()));
  getIt.registerFactory(() => ImageInfoViewModel(getIt(), getIt(instanceName: kWordBox)));
  getIt.registerFactory(() => ThemeViewModel(getIt(), getIt()));
  getIt.registerFactory(() => FilePickerViewModel(getIt()));
  getIt.registerFactory(() => MultiImageViewModel(getIt(), getIt()));
  getIt.registerFactory(() => WordGroupTileExpandedViewModel(getIt(instanceName: kWordBox), getIt(instanceName: kWordGroupBox), getIt(instanceName: kSentenceBox)));
}

@visibleForTesting
void initForTest(final Object object){
  getIt.registerFactory(() => object);
}

Future<void> allReady() {
  return getIt.allReady();
}
