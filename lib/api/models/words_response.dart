//ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'word.dart';

import '../serializers/serializers.dart';

part 'words_response.g.dart';

abstract class WordsResponse implements Built<WordsResponse, WordsResponseBuilder> {

  factory WordsResponse([void Function(WordsResponseBuilder) updates]) = _$WordsResponse;
  WordsResponse._();

  BuiltList<Word> get words;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WordsResponse.serializer, this) as Map<String, dynamic>;
  }

  static WordsResponse fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(WordsResponse.serializer, json)!;
  }

  static Serializer<WordsResponse> get serializer => _$wordsResponseSerializer;
}