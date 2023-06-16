import '../api/hive_client.dart';

const kThemeBox = 'themes';

class ThemeService {

  ThemeService(this.hiveClient);

  final HiveClient hiveClient;

  Future<void> put<T>(String key, T value) async {
    return hiveClient.put<T>(
      key,
      value,
    );
  }

  Future<T> get<T>(
    String key,
    T defaultValue,
  ) async {
    final value = await hiveClient.get<T?>(
      key,
      defaultValue: defaultValue,
    );
    return value ?? defaultValue;
  }

  Future<void> dispose() async {
    hiveClient.dispose();
  }
}
