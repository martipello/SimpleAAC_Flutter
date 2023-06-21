import '../api/hive_client.dart';

const kThemeBox = 'themes';

class ThemeService {

  ThemeService(this.hiveClient);

  final HiveClient<dynamic> hiveClient;

  Future<void> put<T>(String key, T value) async {
    return hiveClient.put(
      key,
      value,
    );
  }

  Future<T> get<T>(
    String key,
    T defaultValue,
  ) async {
    final value = await hiveClient.get(
      key,
      defaultValue: defaultValue,
    );
    return value ?? defaultValue;
  }

  Future<void> dispose() async {
    hiveClient.dispose();
  }
}
