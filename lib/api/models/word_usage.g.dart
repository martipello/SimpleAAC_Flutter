// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordUsage _$WordUsageFromJson(Map<String, dynamic> json) => _WordUsage(
  wordId: json['wordId'] as String,
  count: (json['count'] as num?)?.toInt() ?? 0,
  lastUsed: json['lastUsed'] == null
      ? null
      : DateTime.parse(json['lastUsed'] as String),
);

Map<String, dynamic> _$WordUsageToJson(_WordUsage instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'count': instance.count,
      'lastUsed': instance.lastUsed?.toIso8601String(),
    };
