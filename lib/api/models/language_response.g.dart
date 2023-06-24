// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LanguageResponse> _$languageResponseSerializer =
    new _$LanguageResponseSerializer();

class _$LanguageResponseSerializer
    implements StructuredSerializer<LanguageResponse> {
  @override
  final Iterable<Type> types = const [LanguageResponse, _$LanguageResponse];
  @override
  final String wireName = 'LanguageResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, LanguageResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'languages',
      serializers.serialize(object.languages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Language)])),
    ];

    return result;
  }

  @override
  LanguageResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'languages':
          result.languages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Language)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$LanguageResponse extends LanguageResponse {
  @override
  final BuiltList<Language> languages;

  factory _$LanguageResponse(
          [void Function(LanguageResponseBuilder)? updates]) =>
      (new LanguageResponseBuilder()..update(updates))._build();

  _$LanguageResponse._({required this.languages}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        languages, r'LanguageResponse', 'languages');
  }

  @override
  LanguageResponse rebuild(void Function(LanguageResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageResponseBuilder toBuilder() =>
      new LanguageResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguageResponse && languages == other.languages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, languages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LanguageResponse')
          ..add('languages', languages))
        .toString();
  }
}

class LanguageResponseBuilder
    implements Builder<LanguageResponse, LanguageResponseBuilder> {
  _$LanguageResponse? _$v;

  ListBuilder<Language>? _languages;
  ListBuilder<Language> get languages =>
      _$this._languages ??= new ListBuilder<Language>();
  set languages(ListBuilder<Language>? languages) =>
      _$this._languages = languages;

  LanguageResponseBuilder();

  LanguageResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _languages = $v.languages.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguageResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LanguageResponse;
  }

  @override
  void update(void Function(LanguageResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LanguageResponse build() => _build();

  _$LanguageResponse _build() {
    _$LanguageResponse _$result;
    try {
      _$result = _$v ?? new _$LanguageResponse._(languages: languages.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'languages';
        languages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LanguageResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
