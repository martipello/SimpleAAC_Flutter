import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'sentence.dart';

import '../serializers/serializers.dart';

part 'sentences_response.g.dart';

abstract class SentencesResponse implements Built<SentencesResponse, SentencesResponseBuilder> {

  factory SentencesResponse([final void Function(SentencesResponseBuilder) updates]) = _$SentencesResponse;
  SentencesResponse._();

  BuiltList<Sentence> get sentences;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(SentencesResponse.serializer, this) as Map<String, dynamic>;
  }

  static SentencesResponse fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(SentencesResponse.serializer, json)!;
  }

  static Serializer<SentencesResponse> get serializer => _$sentencesResponseSerializer;
}