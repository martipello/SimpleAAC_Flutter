import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart';
import 'word.dart';

part 'word_response.g.dart';

abstract class WordResponse implements Built<WordResponse, WordResponseBuilder> {

  factory WordResponse([void Function(WordResponseBuilder) updates]) = _$WordResponse;
  WordResponse._();

  BuiltList<Word> get words;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WordResponse.serializer, this) as Map<String, dynamic>;
  }

  static WordResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(WordResponse.serializer, json)!;
  }

  static Serializer<WordResponse> get serializer => _$wordResponseSerializer;
}