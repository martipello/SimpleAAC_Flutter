import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';

part 'word_sub_type.g.dart';

@HiveType(typeId: 3)
class WordSubType extends EnumClass {
  const WordSubType._(String name) : super(name);

  static const WordSubType people = _$people;
  static const WordSubType animals = _$animals;
  static const WordSubType nature = _$nature;
  static const WordSubType time = _$time;
  static const WordSubType places = _$places;
  static const WordSubType things = _$things;
  static const WordSubType ideas = _$ideas;
  static const WordSubType drink = _$drink;
  static const WordSubType food = _$food;
  static const WordSubType action = _$action;
  static const WordSubType feeling = _$feeling;
  static const WordSubType thought = _$thought;
  static const WordSubType sense = _$sense;
  static const WordSubType abverb = _$abverb;
  static const WordSubType helping = _$helping;
  static const WordSubType strong = _$strong;
  static const WordSubType favourites = _$favourites;
  static const WordSubType pronouns = _$pronouns;
  static const WordSubType conjunctions = _$conjunctions;
  static const WordSubType adjectives = _$adjectives;
  static const WordSubType propositionAndSound = _$propositionandsound;
  static const WordSubType phrases = _$phrases;
  static const WordSubType suffix = _$suffix;
  static const WordSubType home = _$home;
  static const WordSubType clothes = _$clothes;
  static const WordSubType extras = _$extras;
  static const WordSubType travel = _$travel;
  static const WordSubType art = _$art;
  static const WordSubType games = _$games;
  static const WordSubType music = _$music;
  static const WordSubType body = _$body;
  static const WordSubType love = _$love;
  static const WordSubType occasion = _$occasion;
  static const WordSubType learning = _$learning;

  static BuiltSet<WordSubType> get values => _$wordSubTypeValues;
  static WordSubType valueOf(String name) => _$wordSubTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(WordSubType.serializer, this) as String;
  }

  static WordSubType deserialize(String string) {
    return serializers.deserializeWith(WordSubType.serializer, string)!;
  }

  static Serializer<WordSubType> get serializer => _$wordSubTypeSerializer;
}