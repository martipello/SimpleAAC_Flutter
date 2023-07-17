import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_aac/ui/shared_widgets/view_model/multi_image_view_model.dart';
import 'package:simple_aac/ui/shared_widgets/word_group_tile_expanded_view_model.dart';
import 'package:simple_aac/view_models/language_view_model.dart';

import 'api/hive_client.dart';
import 'api/models/language.dart';
import 'services/language_service.dart';
import 'services/navigation_service.dart';
import 'services/shared_preferences_service.dart';
import 'services/theme_service.dart';
import 'services/word_base_service.dart';
import 'ui/theme/theme_controller.dart';
import 'view_models/create_word/manage_word_view_model.dart';
import 'view_models/file_picker/file_picker_view_model.dart';
import 'view_models/intro/intro_view_model.dart';
import 'view_models/selected_words_view_model.dart';
import 'view_models/theme_view_model.dart';
import 'view_models/utils/tab_bar_view_model.dart';
import 'view_models/words_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingletonAsync(SharedPreferences.getInstance);
  getIt.registerLazySingletonAsync(PackageInfo.fromPlatform);
  getIt.registerSingletonAsync(() => HiveClient.create<dynamic>(kThemeBox), instanceName: kThemeBox);
  getIt.registerSingletonAsync(() => HiveClient.create<Language>(kLanguageBox), instanceName: kLanguageBox);
  await getIt.isReady<HiveClient>(instanceName: kThemeBox);
  await getIt.isReady<HiveClient>(instanceName: kLanguageBox);
  await getIt.isReady<SharedPreferences>();
  await getIt.isReady<PackageInfo>();
  await getIt.isReady<SharedPreferences>();
  getIt.registerLazySingleton(() => LanguageService(getIt(instanceName: kLanguageBox), getIt()));
  getIt.registerLazySingleton(() => WordBaseService(getIt()));
  getIt.registerLazySingleton(DefaultCacheManager.new);
  getIt.registerLazySingleton(() => SharedPreferencesService(getIt()));
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(NavigationService.new);
  getIt.registerLazySingleton(ImagePicker.new);
  getIt.registerLazySingleton(() => SelectedWordsViewModel(getIt()));
  getIt.registerFactory(() => ThemeService(getIt(instanceName: kThemeBox)));
  getIt.registerFactory(() => ThemeController(getIt()));
  getIt.registerFactory(() => WordsViewModel(getIt()));
  getIt.registerFactory(() => LanguageViewModel(getIt()));
  getIt.registerFactory(IntroViewModel.new);
  getIt.registerFactory(TabBarViewModel.new);
  getIt.registerFactory(() => ManageWordViewModel(getIt()));
  getIt.registerFactory(() => ThemeViewModel(getIt(), getIt()));
  getIt.registerFactory(() => FilePickerViewModel(getIt()));
  getIt.registerFactory(() => MultiImageViewModel(getIt()));
  getIt.registerFactory(() => WordGroupTileExpandedViewModel());
}

@visibleForTesting
void initForTest(Object object){
  getIt.registerFactory(() => object);
}

Future<void> allReady() {
  return getIt.allReady();
}
