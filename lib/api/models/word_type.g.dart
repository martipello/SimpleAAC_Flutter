// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const WordType _$quicks = const WordType._('quicks');
const WordType _$nouns = const WordType._('nouns');
const WordType _$verbs = const WordType._('verbs');
const WordType _$other = const WordType._('other');

WordType _$wordTypeValueOf(String name) {
  switch (name) {
    case 'quicks':
      return _$quicks;
    case 'nouns':
      return _$nouns;
    case 'verbs':
      return _$verbs;
    case 'other':
      return _$other;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<WordType> _$wordTypeValues = new BuiltSet<WordType>(const <WordType>[
  _$quicks,
  _$nouns,
  _$verbs,
  _$other,
]);

Serializer<WordType> _$wordTypeSerializer = new _$WordTypeSerializer();

class _$WordTypeSerializer implements PrimitiveSerializer<WordType> {
  @override
  final Iterable<Type> types = const <Type>[WordType];
  @override
  final String wireName = 'WordType';

  @override
  Object serialize(Serializers serializers, WordType object, {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  WordType deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) =>
      WordType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
