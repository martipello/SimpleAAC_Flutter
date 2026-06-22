// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  userId: json['userId'] as String,
  currentLanguageId: json['currentLanguageId'] as String? ?? 'l1',
  favouriteWordIds:
      (json['favouriteWordIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentLanguageId': instance.currentLanguageId,
      'favouriteWordIds': instance.favouriteWordIds,
    };
