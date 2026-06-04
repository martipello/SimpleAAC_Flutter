// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Language _$LanguageFromJson(Map<String, dynamic> json) => _Language(
  id: json['id'] as String,
  displayName: json['displayName'] as String,
  words:
      (json['words'] as List<dynamic>?)
          ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$LanguageToJson(_Language instance) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'words': instance.words,
};
