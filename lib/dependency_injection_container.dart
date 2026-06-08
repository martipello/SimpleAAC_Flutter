import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/repositories/user_repository.dart';
import 'api/repositories/vocabulary_repository.dart';
import 'api/repositories/word_group_repository.dart';
import 'api/repositories/word_usage_repository.dart';
import 'services/ai_prediction_service.dart';
import 'services/auth_service.dart';
import 'services/image_path_service.dart';
import 'services/language_service.dart';
import 'services/navigation_service.dart';
import 'services/shared_preferences_service.dart';
import 'services/theme_service.dart';
import 'services/tts_service.dart';
import 'services/word_group_service.dart';
import 'services/word_service.dart';
import 'services/word_usage_service.dart';
import 'ui/theme/theme_controller.dart';
import 'view_models/create_word/manage_word_view_model.dart';
import 'view_models/file_picker/file_picker_view_model.dart';
import 'view_models/intro/intro_view_model.dart';
import 'view_models/language_view_model.dart';
import 'view_models/selected_words_view_model.dart';
import 'view_models/theme_view_model.dart';
import 'view_models/utils/tab_bar_view_model.dart';
import 'view_models/word_group_view_model.dart';
import 'view_models/words_view_model.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Firebase
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // Configure Firestore offline persistence
  firestore.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  getIt.registerSingleton<FirebaseFirestore>(firestore);
  getIt.registerSingleton<FirebaseAuth>(auth);

  // Platform services
  getIt.registerLazySingletonAsync(SharedPreferences.getInstance);
  getIt.registerLazySingletonAsync(PackageInfo.fromPlatform);
  await getIt.isReady<SharedPreferences>();
  await getIt.isReady<PackageInfo>();

  // Repositories
  getIt.registerLazySingleton(
    () => VocabularyRepository(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton(
    () => WordUsageRepository(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton(
    () => UserRepository(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton(
    () => WordGroupRepository(getIt<FirebaseFirestore>()),
  );

  // Services
  getIt.registerLazySingleton(() => AuthService(getIt<FirebaseAuth>()));
  getIt.registerLazySingleton(
    () => SharedPreferencesService(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton(
    () => LanguageService(
      getIt<VocabularyRepository>(),
      getIt<SharedPreferencesService>(),
    ),
  );
  getIt.registerLazySingleton(
    () => WordService(
      getIt<VocabularyRepository>(),
      getIt<AuthService>(),
      getIt<LanguageService>(),
    ),
  );
  getIt.registerLazySingleton(
    () => WordUsageService(
      getIt<WordUsageRepository>(),
      getIt<AuthService>(),
    ),
  );
  getIt.registerLazySingleton(
    () => WordGroupService(
      getIt<WordGroupRepository>(),
      getIt<AuthService>(),
      getIt<WordService>(),
    ),
  );
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(NavigationService.new);
  getIt.registerLazySingleton(() => ImagePathService(getIt<SharedPreferencesService>()));
  getIt.registerLazySingleton(() => TtsService(getIt<SharedPreferencesService>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => AiPredictionService(getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(ImagePicker.new);

  // ViewModels (singletons for shared state, factories for per-screen)
  getIt.registerLazySingleton(
    () => SelectedWordsViewModel(
      getIt<WordService>(),
      getIt<WordUsageService>(),
      getIt<TtsService>(),
      getIt<AiPredictionService>(),
      getIt<SharedPreferencesService>(),
    ),
  );
  getIt.registerFactory(
    () => ThemeService(getIt<SharedPreferencesService>()),
  );
  getIt.registerFactory(() => ThemeController(getIt<ThemeService>()));
  getIt.registerFactory(() => WordsViewModel(getIt<WordService>(), getIt<WordUsageService>()));
  getIt.registerFactory(() => LanguageViewModel(getIt<LanguageService>()));
  getIt.registerFactory(IntroViewModel.new);
  getIt.registerFactory(TabBarViewModel.new);
  getIt.registerFactory(
    () => ManageWordViewModel(getIt<WordService>()),
  );
  getIt.registerFactory(
    () => ThemeViewModel(getIt<ThemeController>(), getIt<SharedPreferencesService>()),
  );
  getIt.registerFactory(() => FilePickerViewModel(getIt()));
  getIt.registerFactory(
    () => WordGroupViewModel(getIt<WordGroupService>()),
  );
}

Future<void> allReady() => getIt.allReady();
