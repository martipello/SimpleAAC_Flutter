import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';
import 'language.dart';
import 'word_base.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

import '../serializers/serializers.dart';

part 'word_group.g.dart';

@Entity(tableName: 'Word')
class WordGroup extends WordBase {

  final String displayName;

  @HiveField(8)
  double? get usageCount;

  @HiveField(9)
  BuiltList<Language> get languages;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WordGroup.serializer, this) as Map<String, dynamic>;
  }

  static WordGroup fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(WordGroup.serializer, json)!;
  }

  static Serializer<WordGroup> get serializer => _$wordGroupSerializer;
}