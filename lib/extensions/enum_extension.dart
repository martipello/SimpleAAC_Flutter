//not technically an extension
String enumToString(Object? o) => o != null ? o.toString().split('.').last : '';

T? enumFromString<T>(String key, List<T> values) {
  try {
    return values.firstWhere((v) => key == enumToString(v));
  } catch (e) {
    return null;
  }
}
