import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';
import 'word_base.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

part 'sentence.g.dart';

@HiveType(typeId: 2)
abstract class Sentence with WordBase implements Built<Sentence, SentenceBuilder> {

  factory Sentence([final void Function(SentenceBuilder) updates]) = _$Sentence;
  Sentence._();

  @HiveField(9)
  BuiltList<String> get wordIds;

  @HiveField(10)
  BuiltList<String> get extraRelatedWordIds;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Sentence.serializer, this) as Map<String, dynamic>;
  }

  static Sentence fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(Sentence.serializer, json)!;
  }

  static Serializer<Sentence> get serializer => _$sentenceSerializer;
}