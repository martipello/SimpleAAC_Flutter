import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';

part 'word_type.g.dart';

@HiveType(typeId: 2)
class WordType extends EnumClass {
  const WordType._(String name) : super(name);
  static const WordType quicks = _$quicks;
  static const WordType nouns = _$nouns;
  static const WordType verbs = _$verbs;
  static const WordType other = _$other;

  static BuiltSet<WordType> get values => _$wordTypeValues;
  static WordType valueOf(String name) => _$wordTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(WordType.serializer, this) as String;
  }

  static WordType deserialize(String string) {
    return serializers.deserializeWith(WordType.serializer, string)!;
  }

  static Serializer<WordType> get serializer => _$wordTypeSerializer;
}
