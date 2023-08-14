//ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart';
import 'language.dart';

part 'languages_response.g.dart';

abstract class LanguagesResponse implements Built<LanguagesResponse, LanguagesResponseBuilder> {

  factory LanguagesResponse([void Function(LanguagesResponseBuilder) updates]) = _$LanguagesResponse;
  LanguagesResponse._();

  BuiltList<Language> get languages;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(LanguagesResponse.serializer, this) as Map<String, dynamic>;
  }

  static LanguagesResponse fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(LanguagesResponse.serializer, json)!;
  }

  static Serializer<LanguagesResponse> get serializer => _$languagesResponseSerializer;
}