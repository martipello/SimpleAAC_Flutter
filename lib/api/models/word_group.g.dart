// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WordGroup _$WordGroupFromJson(Map<String, dynamic> json) => _WordGroup(
  id: json['id'] as String,
  title: json['title'] as String,
  wordIds: (json['wordIds'] as List<dynamic>).map((e) => e as String).toList(),
  phoneticOverride: json['phoneticOverride'] as String?,
  imagePath: json['imagePath'] as String?,
  isFavourite: json['isFavourite'] as bool? ?? false,
  usageCount: (json['usageCount'] as num?)?.toInt() ?? 0,
  createdDate: json['createdDate'] == null
      ? null
      : DateTime.parse(json['createdDate'] as String),
);

Map<String, dynamic> _$WordGroupToJson(_WordGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'wordIds': instance.wordIds,
      'phoneticOverride': instance.phoneticOverride,
      'imagePath': instance.imagePath,
      'isFavourite': instance.isFavourite,
      'usageCount': instance.usageCount,
      'createdDate': instance.createdDate?.toIso8601String(),
    };
