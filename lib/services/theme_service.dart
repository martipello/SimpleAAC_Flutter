import '../api/hive_client.dart';
import '../dependency_injection_container.dart';
import '../ui/theme/store.dart';

const kThemeBox = 'themes';

class ThemeService {
  final _hiveClient = getIt.getAsync<HiveClient>(instanceName: kThemeBox);

  Future<void> put<T>(String key, T value) async {
    final hiveClient = await _hiveClient;
    return hiveClient.put<T>(
      key,
      value,
    );
  }

  Future<T> get<T>(
    String key,
    T defaultValue,
  ) async {
    final hiveClient = await _hiveClient;
    final value = await hiveClient.get<T>(
      key,
      defaultValue: defaultValue,
    );
    return value ?? defaultValue;
  }
}
