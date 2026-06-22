// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LanguageResponse _$LanguageResponseFromJson(Map<String, dynamic> json) =>
    _LanguageResponse(
      languages:
          (json['languages'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LanguageResponseToJson(_LanguageResponse instance) =>
    <String, dynamic>{'languages': instance.languages};
