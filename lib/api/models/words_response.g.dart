// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WordsResponse> _$wordsResponseSerializer =
    new _$WordsResponseSerializer();

class _$WordsResponseSerializer implements StructuredSerializer<WordsResponse> {
  @override
  final Iterable<Type> types = const [WordsResponse, _$WordsResponse];
  @override
  final String wireName = 'WordsResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, WordsResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'words',
      serializers.serialize(object.words,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Word)])),
    ];

    return result;
  }

  @override
  WordsResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WordsResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'words':
          result.words.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Word)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$WordsResponse extends WordsResponse {
  @override
  final BuiltList<Word> words;

  factory _$WordsResponse([void Function(WordsResponseBuilder)? updates]) =>
      (new WordsResponseBuilder()..update(updates))._build();

  _$WordsResponse._({required this.words}) : super._() {
    BuiltValueNullFieldError.checkNotNull(words, r'WordsResponse', 'words');
  }

  @override
  WordsResponse rebuild(void Function(WordsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WordsResponseBuilder toBuilder() => new WordsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WordsResponse && words == other.words;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, words.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WordsResponse')..add('words', words))
        .toString();
  }
}

class WordsResponseBuilder
    implements Builder<WordsResponse, WordsResponseBuilder> {
  _$WordsResponse? _$v;

  ListBuilder<Word>? _words;
  ListBuilder<Word> get words => _$this._words ??= new ListBuilder<Word>();
  set words(ListBuilder<Word>? words) => _$this._words = words;

  WordsResponseBuilder();

  WordsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _words = $v.words.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WordsResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WordsResponse;
  }

  @override
  void update(void Function(WordsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WordsResponse build() => _build();

  _$WordsResponse _build() {
    _$WordsResponse _$result;
    try {
      _$result = _$v ?? new _$WordsResponse._(words: words.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'words';
        words.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WordsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
