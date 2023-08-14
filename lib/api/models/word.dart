import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

import '../serializers/serializers.dart';
import 'word_base.dart';

part 'word.g.dart';

@HiveType(typeId: 1)
abstract class Word with WordBase implements Built<Word, WordBuilder> {

  factory Word([final void Function(WordBuilder) updates]) = _$Word;
  Word._();

  @HiveField(9)
  String get word;

  @HiveField(10)
  String get imageId;

  @HiveField(11)
  String get sound;

  @HiveField(12)
  double? get keyStage;

  @HiveField(14)
  BuiltList<String> get extraRelatedWordIds;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Word.serializer, this) as Map<String, dynamic>;
  }

  static Word fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(Word.serializer, json)!;
  }

  static Serializer<Word> get serializer => _$wordSerializer;
}