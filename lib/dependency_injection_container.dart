import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/hive_client.dart';
import 'services/navigation_service.dart';
import 'services/shared_preferences_service.dart';
import 'services/theme_service.dart';
import 'services/word_service.dart';
import 'ui/theme/theme_controller.dart';
import 'view_models/create_word/manage_word_view_model.dart';
import 'view_models/file_picker/file_picker_view_model.dart';
import 'view_models/intro/intro_view_model.dart';
import 'view_models/selected_words_view_model.dart';
import 'view_models/theme_view_model.dart';
import 'view_models/utils/tab_bar_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingletonAsync(SharedPreferences.getInstance);
  getIt.registerLazySingletonAsync(PackageInfo.fromPlatform);
  getIt.registerLazySingletonAsync(() => HiveClient.init(kThemeBox), instanceName: kThemeBox);
  getIt.registerLazySingletonAsync(() => HiveClient.init(kWordBox), instanceName: kWordBox);
  getIt.registerFactory(ThemeService.new);
  getIt.registerFactory(() => ThemeController(getIt()));
  getIt.registerLazySingleton(SharedPreferencesService.new);
  getIt.registerLazySingleton(() => WordService(getIt(instanceName: kWordBox)));
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(NavigationService.new);
  getIt.registerLazySingleton(ImagePicker.new);
  getIt.registerLazySingleton(SelectedWordsViewModel.new);
  getIt.registerFactory(IntroViewModel.new);
  getIt.registerFactory(TabBarViewModel.new);
  getIt.registerFactory(ManageWordViewModel.new);
  getIt.registerFactory(() => ThemeViewModel(getIt(), getIt()));
  getIt.registerFactory(() => FilePickerViewModel(getIt()));
}

Future<void> allReady() {
  return getIt.allReady();
}
