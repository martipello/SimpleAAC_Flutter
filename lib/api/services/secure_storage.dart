import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hive/hive.dart';

class SecureStorage {
  SecureStorage(this.storage);

  final FlutterSecureStorage storage;

  Future<String?> getValue(final String key) => storage.read(key: key);

  Future<Map<String, String>> get allValues => storage.readAll();

  Future<void> deleteValue(final String key) {
    return storage.delete(key: key);
  }

  Future<bool> containsKey({required final String key}) {
    return storage.containsKey(key: key);
  }

  Future<void> get deleteAll => storage.deleteAll();

  Future<void> writeValue(final String key, final String value) {
    return storage.write(key: key, value: value);
  }
}
