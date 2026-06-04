// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Word _$WordFromJson(Map<String, dynamic> json) => _Word(
  wordId: json['wordId'] as String,
  text: json['text'] as String,
  phoneticOverride: json['phoneticOverride'] as String?,
  type: $enumDecode(_$WordTypeEnumMap, json['type']),
  subType: $enumDecode(_$WordSubTypeEnumMap, json['subType']),
  imagePaths: (json['imagePaths'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isCoreVocabulary: json['isCoreVocabulary'] as bool? ?? true,
  isFavourite: json['isFavourite'] as bool? ?? false,
  extraRelatedWordIds:
      (json['extraRelatedWordIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  aiSuggestedFollowUps:
      (json['aiSuggestedFollowUps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  localEmbedding: (json['localEmbedding'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  createdDate: json['createdDate'] == null
      ? null
      : DateTime.parse(json['createdDate'] as String),
);

Map<String, dynamic> _$WordToJson(_Word instance) => <String, dynamic>{
  'wordId': instance.wordId,
  'text': instance.text,
  'phoneticOverride': instance.phoneticOverride,
  'type': _$WordTypeEnumMap[instance.type]!,
  'subType': _$WordSubTypeEnumMap[instance.subType]!,
  'imagePaths': instance.imagePaths,
  'isCoreVocabulary': instance.isCoreVocabulary,
  'isFavourite': instance.isFavourite,
  'extraRelatedWordIds': instance.extraRelatedWordIds,
  'aiSuggestedFollowUps': instance.aiSuggestedFollowUps,
  'localEmbedding': instance.localEmbedding,
  'createdDate': instance.createdDate?.toIso8601String(),
};

const _$WordTypeEnumMap = {
  WordType.core: 'core',
  WordType.things: 'things',
  WordType.actions: 'actions',
  WordType.describe: 'describe',
  WordType.social: 'social',
  WordType.grammar: 'grammar',
};

const _$WordSubTypeEnumMap = {
  WordSubType.people: 'people',
  WordSubType.animals: 'animals',
  WordSubType.nature: 'nature',
  WordSubType.food: 'food',
  WordSubType.drink: 'drink',
  WordSubType.body: 'body',
  WordSubType.clothes: 'clothes',
  WordSubType.home: 'home',
  WordSubType.travel: 'travel',
  WordSubType.places: 'places',
  WordSubType.art: 'art',
  WordSubType.music: 'music',
  WordSubType.games: 'games',
  WordSubType.occasions: 'occasions',
  WordSubType.action: 'action',
  WordSubType.helping: 'helping',
  WordSubType.strong: 'strong',
  WordSubType.adjectives: 'adjectives',
  WordSubType.sense: 'sense',
  WordSubType.feeling: 'feeling',
  WordSubType.thought: 'thought',
  WordSubType.phrases: 'phrases',
  WordSubType.favourites: 'favourites',
  WordSubType.greetings: 'greetings',
  WordSubType.pronouns: 'pronouns',
  WordSubType.conjunctions: 'conjunctions',
  WordSubType.prepositions: 'prepositions',
  WordSubType.suffix: 'suffix',
};
