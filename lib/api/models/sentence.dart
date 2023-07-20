import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'word.dart';
import 'word_base.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

import '../serializers/serializers.dart';

part 'sentence.g.dart';

@HiveType(typeId: 4)
abstract class Sentence with WordBase implements Built<Sentence, SentenceBuilder> {

  factory Sentence([final void Function(SentenceBuilder) updates]) = _$Sentence;
  Sentence._();

  @HiveField(0)
  String get id;

  @HiveField(1)
  DateTime? get createdDate;

  @HiveField(2)
  WordType get type;

  @HiveField(3)
  WordSubType get subType;

  @HiveField(4)
  BuiltList<Word> get words;

  @HiveField(6)
  String get sound;

  @HiveField(7)
  bool? get isFavourite;

  @HiveField(8)
  double? get usageCount;

  @HiveField(10)
  bool? get isUserAdded;

  @HiveField(11)
  bool? get isBackedUp;

  @HiveField(12)
  BuiltList<String> get extraRelatedWordIds;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Sentence.serializer, this) as Map<String, dynamic>;
  }

  static Sentence fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(Sentence.serializer, json)!;
  }

  static Serializer<Sentence> get serializer => _$sentenceSerializer;
}