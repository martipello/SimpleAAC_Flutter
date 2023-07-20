//not technically an extension
String enumToString(final Object? o) => o != null ? o.toString().split('.').last : '';

T? enumFromString<T>(final String key, final List<T> values) {
  try {
    return values.firstWhere((final v) => key == enumToString(v));
  } catch (e) {
    return null;
  }
}
