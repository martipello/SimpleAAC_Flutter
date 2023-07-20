import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'word_base.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

import '../serializers/serializers.dart';

part 'word_group.g.dart';

@HiveType(typeId: 5)
abstract class WordGroup with WordBase implements Built<WordGroup, WordGroupBuilder> {

  factory WordGroup([final void Function(WordGroupBuilder) updates]) = _$WordGroup;
  WordGroup._();

  @HiveField(0)
  String get id;

  @HiveField(1)
  String get displayName;

  @HiveField(2)
  DateTime? get createdDate;

  @HiveField(3)
  WordType get type;

  @HiveField(4)
  WordSubType get subType;

  @HiveField(5)
  BuiltList<WordBase> get words;

  @HiveField(6)
  bool? get isBackedUp;

  @HiveField(7)
  bool? get isFavourite;

  @HiveField(8)
  double? get usageCount;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WordGroup.serializer, this) as Map<String, dynamic>;
  }

  static WordGroup fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(WordGroup.serializer, json)!;
  }

  static Serializer<WordGroup> get serializer => _$wordGroupSerializer;
}