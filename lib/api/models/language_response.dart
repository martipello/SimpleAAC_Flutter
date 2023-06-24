import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart';
import 'language.dart';

part 'language_response.g.dart';

abstract class LanguageResponse implements Built<LanguageResponse, LanguageResponseBuilder> {

  factory LanguageResponse([void Function(LanguageResponseBuilder) updates]) = _$LanguageResponse;
  LanguageResponse._();

  BuiltList<Language> get languages;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(LanguageResponse.serializer, this) as Map<String, dynamic>;
  }

  static LanguageResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(LanguageResponse.serializer, json)!;
  }

  static Serializer<LanguageResponse> get serializer => _$languageResponseSerializer;
}