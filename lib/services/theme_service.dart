import 'dart:convert';

import 'shared_preferences_service.dart';

const kThemeKey = 'theme_settings';

/// Stores theme settings as a JSON map in SharedPreferences.
/// Only JSON primitives (bool, int, double, String) and enums (stored as name)
/// are persisted. All other types (Color, complex objects) are silently ignored
/// and fall back to the default value on load.
class ThemeService {
  ThemeService(this._prefs);

  final SharedPreferencesService _prefs;

  Future<void> put<T>(String key, T value) async {
    final storable = _toStorable(value);
    if (storable == null) return; // non-serializable — skip silently
    final map = await _loadMap();
    map[key] = storable;
    await _saveMap(map);
  }

  Future<T> get<T>(String key, T defaultValue) async {
    final map = await _loadMap();
    final stored = map[key];
    if (stored == null) return defaultValue;
    if (stored is T) return stored;
    return defaultValue;
  }

  /// Converts a value to a JSON-safe primitive, or null if not possible.
  dynamic _toStorable(dynamic value) {
    if (value == null) return null;
    if (value is bool || value is int || value is double || value is String) {
      return value;
    }
    if (value is Enum) return value.name;
    return null; // Color, complex objects — skip
  }

  Future<Map<String, dynamic>> _loadMap() async {
    final raw = _prefs.preferences.getString(kThemeKey);
    if (raw == null) return {};
    try {
      return Map<String, dynamic>.from(jsonDecode(raw) as Map);
    } catch (_) {
      return {};
    }
  }

  Future<void> _saveMap(Map<String, dynamic> map) async {
    await _prefs.preferences.setString(kThemeKey, jsonEncode(map));
  }

  void dispose() {}
}
