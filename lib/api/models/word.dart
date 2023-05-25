import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
abstract class Word implements Built<Word, WordBuilder> {

  factory Word([void Function(WordBuilder) updates]) = _$Word;
  Word._();

  @HiveField(0)
  String get wordId;

  @HiveField(1)
  DateTime? get createdDate;

  @HiveField(2)
  WordType get type;

  @HiveField(3)
  WordSubType get subType;

  @HiveField(4)
  String get word;

  @HiveField(5)
  BuiltList<String> get imageList;

  @HiveField(6)
  String get sound;

  @HiveField(7)
  bool? get isFavourite;

  @HiveField(8)
  double? get usageCount;

  @HiveField(9)
  double? get keyStage;

  @HiveField(10)
  bool? get isUserAdded;

  @HiveField(11)
  bool? get isBackedUp;

  @HiveField(12)
  BuiltList<Word> get predictionList;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Word.serializer, this) as Map<String, dynamic>;
  }

  static Word fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Word.serializer, json)!;
  }

  static Serializer<Word> get serializer => _$wordSerializer;
}