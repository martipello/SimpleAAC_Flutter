import 'package:built_value/serializer.dart';

class DateTimeSerializer implements PrimitiveSerializer<DateTime?> {
  @override
  DateTime? deserialize(final Serializers serializers, final Object? serialized, {final FullType specifiedType = FullType.unspecified}) {
    if (serialized != null && serialized is String && serialized.isNotEmpty) {
      return DateTime.parse(serialized).toLocal();
    } else {
      //TODO this should return null
      return DateTime.now();
    }
  }

  @override
  Object serialize(final Serializers serializers, final DateTime? object, {final FullType specifiedType = FullType.unspecified}) {
    if (object != null) {
      return object.toUtc().toIso8601String();
    } else {
      return Object();
    }
  }

  @override
  Iterable<Type> get types => [DateTime];

  @override
  String get wireName => 'DateTime';
}
