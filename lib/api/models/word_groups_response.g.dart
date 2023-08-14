// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_groups_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WordGroupsResponse> _$wordGroupsResponseSerializer =
    new _$WordGroupsResponseSerializer();

class _$WordGroupsResponseSerializer
    implements StructuredSerializer<WordGroupsResponse> {
  @override
  final Iterable<Type> types = const [WordGroupsResponse, _$WordGroupsResponse];
  @override
  final String wireName = 'WordGroupsResponse';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, WordGroupsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'wordGroups',
      serializers.serialize(object.wordGroups,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WordGroup)])),
    ];

    return result;
  }

  @override
  WordGroupsResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WordGroupsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'wordGroups':
          result.wordGroups.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WordGroup)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$WordGroupsResponse extends WordGroupsResponse {
  @override
  final BuiltList<WordGroup> wordGroups;

  factory _$WordGroupsResponse(
          [void Function(WordGroupsResponseBuilder)? updates]) =>
      (new WordGroupsResponseBuilder()..update(updates))._build();

  _$WordGroupsResponse._({required this.wordGroups}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        wordGroups, r'WordGroupsResponse', 'wordGroups');
  }

  @override
  WordGroupsResponse rebuild(
          void Function(WordGroupsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WordGroupsResponseBuilder toBuilder() =>
      new WordGroupsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WordGroupsResponse && wordGroups == other.wordGroups;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, wordGroups.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WordGroupsResponse')
          ..add('wordGroups', wordGroups))
        .toString();
  }
}

class WordGroupsResponseBuilder
    implements Builder<WordGroupsResponse, WordGroupsResponseBuilder> {
  _$WordGroupsResponse? _$v;

  ListBuilder<WordGroup>? _wordGroups;
  ListBuilder<WordGroup> get wordGroups =>
      _$this._wordGroups ??= new ListBuilder<WordGroup>();
  set wordGroups(ListBuilder<WordGroup>? wordGroups) =>
      _$this._wordGroups = wordGroups;

  WordGroupsResponseBuilder();

  WordGroupsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _wordGroups = $v.wordGroups.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WordGroupsResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WordGroupsResponse;
  }

  @override
  void update(void Function(WordGroupsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WordGroupsResponse build() => _build();

  _$WordGroupsResponse _build() {
    _$WordGroupsResponse _$result;
    try {
      _$result =
          _$v ?? new _$WordGroupsResponse._(wordGroups: wordGroups.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'wordGroups';
        wordGroups.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WordGroupsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
