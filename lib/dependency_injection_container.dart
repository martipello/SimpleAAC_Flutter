import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_aac/view_models/selected_words_view_model.dart';

import 'services/navigation_service.dart';
import 'services/shared_preferences_service.dart';
import 'view_models/create_word/create_word_view_model.dart';
import 'view_models/file_picker/file_picker_view_model.dart';
import 'view_models/intro/intro_view_model.dart';
import 'view_models/utils/tab_bar_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingletonAsync(SharedPreferences.getInstance);
  getIt.registerLazySingletonAsync(PackageInfo.fromPlatform);
  getIt.registerLazySingleton(() => SharedPreferencesService());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton(() => ImagePicker());
  getIt.registerLazySingleton(() => SelectedWordsViewModel());
  getIt.registerFactory(() => IntroViewModel());
  getIt.registerFactory(() => TabBarViewModel());
  getIt.registerFactory(() => FilePickerViewModel(getIt()));
  getIt.registerFactory(() => CreateWordViewModel());
}
