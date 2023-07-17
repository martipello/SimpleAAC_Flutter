import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:simple_aac/api/models/word_group.dart';

import '../serializers/serializers.dart';

part 'word_groups_response.g.dart';

abstract class WordGroupsResponse implements Built<WordGroupsResponse, WordGroupsResponseBuilder> {
  factory WordGroupsResponse([void Function(WordGroupsResponseBuilder) updates]) = _$WordGroupsResponse;

  WordGroupsResponse._();

  BuiltList<WordGroup> get wordGroups;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WordGroupsResponse.serializer, this) as Map<String, dynamic>;
  }

  static WordGroupsResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(WordGroupsResponse.serializer, json)!;
  }

  static Serializer<WordGroupsResponse> get serializer => _$wordGroupsResponseSerializer;
}
