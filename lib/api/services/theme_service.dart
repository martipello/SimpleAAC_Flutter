import '../hive_client.dart';

const kThemeBox = 'themes';

class ThemeService {

  ThemeService(this.hiveClient);

  final HiveClient<dynamic> hiveClient;

  Future<void> put<T>(final String key, final T value) async {
    return hiveClient.put(
      key,
      value,
    );
  }

  Future<T> get<T>(
    final String key,
    final T defaultValue,
  ) async {
    final value = await hiveClient.get(
      key,
      defaultValue: defaultValue,
    );
    return value ?? defaultValue;
  }

  Future<void> dispose() async {
    await hiveClient.dispose();
  }
}
