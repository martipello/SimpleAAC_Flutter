import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';
import 'word_base.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

part 'word_group.g.dart';

@HiveType(typeId: 3)
abstract class WordGroup with WordBase implements Built<WordGroup, WordGroupBuilder> {

  factory WordGroup([final void Function(WordGroupBuilder) updates]) = _$WordGroup;
  WordGroup._();

  @HiveField(9)
  String get displayName;

  @HiveField(10)
  BuiltList<String> get wordIds;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WordGroup.serializer, this) as Map<String, dynamic>;
  }

  static WordGroup fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(WordGroup.serializer, json)!;
  }

  static Serializer<WordGroup> get serializer => _$wordGroupSerializer;
}