// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentences_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SentencesResponse> _$sentencesResponseSerializer =
    new _$SentencesResponseSerializer();

class _$SentencesResponseSerializer
    implements StructuredSerializer<SentencesResponse> {
  @override
  final Iterable<Type> types = const [SentencesResponse, _$SentencesResponse];
  @override
  final String wireName = 'SentencesResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, SentencesResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'sentences',
      serializers.serialize(object.sentences,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Sentence)])),
    ];

    return result;
  }

  @override
  SentencesResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SentencesResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'sentences':
          result.sentences.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Sentence)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$SentencesResponse extends SentencesResponse {
  @override
  final BuiltList<Sentence> sentences;

  factory _$SentencesResponse(
          [void Function(SentencesResponseBuilder)? updates]) =>
      (new SentencesResponseBuilder()..update(updates))._build();

  _$SentencesResponse._({required this.sentences}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        sentences, r'SentencesResponse', 'sentences');
  }

  @override
  SentencesResponse rebuild(void Function(SentencesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SentencesResponseBuilder toBuilder() =>
      new SentencesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SentencesResponse && sentences == other.sentences;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sentences.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SentencesResponse')
          ..add('sentences', sentences))
        .toString();
  }
}

class SentencesResponseBuilder
    implements Builder<SentencesResponse, SentencesResponseBuilder> {
  _$SentencesResponse? _$v;

  ListBuilder<Sentence>? _sentences;
  ListBuilder<Sentence> get sentences =>
      _$this._sentences ??= new ListBuilder<Sentence>();
  set sentences(ListBuilder<Sentence>? sentences) =>
      _$this._sentences = sentences;

  SentencesResponseBuilder();

  SentencesResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sentences = $v.sentences.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SentencesResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SentencesResponse;
  }

  @override
  void update(void Function(SentencesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SentencesResponse build() => _build();

  _$SentencesResponse _build() {
    _$SentencesResponse _$result;
    try {
      _$result = _$v ?? new _$SentencesResponse._(sentences: sentences.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sentences';
        sentences.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SentencesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
