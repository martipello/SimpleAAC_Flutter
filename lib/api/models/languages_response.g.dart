// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'languages_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LanguagesResponse> _$languagesResponseSerializer =
    new _$LanguagesResponseSerializer();

class _$LanguagesResponseSerializer
    implements StructuredSerializer<LanguagesResponse> {
  @override
  final Iterable<Type> types = const [LanguagesResponse, _$LanguagesResponse];
  @override
  final String wireName = 'LanguagesResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, LanguagesResponse object,
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
  LanguagesResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguagesResponseBuilder();

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

class _$LanguagesResponse extends LanguagesResponse {
  @override
  final BuiltList<Language> languages;

  factory _$LanguagesResponse(
          [void Function(LanguagesResponseBuilder)? updates]) =>
      (new LanguagesResponseBuilder()..update(updates))._build();

  _$LanguagesResponse._({required this.languages}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        languages, r'LanguagesResponse', 'languages');
  }

  @override
  LanguagesResponse rebuild(void Function(LanguagesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguagesResponseBuilder toBuilder() =>
      new LanguagesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LanguagesResponse && languages == other.languages;
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
    return (newBuiltValueToStringHelper(r'LanguagesResponse')
          ..add('languages', languages))
        .toString();
  }
}

class LanguagesResponseBuilder
    implements Builder<LanguagesResponse, LanguagesResponseBuilder> {
  _$LanguagesResponse? _$v;

  ListBuilder<Language>? _languages;
  ListBuilder<Language> get languages =>
      _$this._languages ??= new ListBuilder<Language>();
  set languages(ListBuilder<Language>? languages) =>
      _$this._languages = languages;

  LanguagesResponseBuilder();

  LanguagesResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _languages = $v.languages.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LanguagesResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LanguagesResponse;
  }

  @override
  void update(void Function(LanguagesResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LanguagesResponse build() => _build();

  _$LanguagesResponse _build() {
    _$LanguagesResponse _$result;
    try {
      _$result = _$v ?? new _$LanguagesResponse._(languages: languages.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'languages';
        languages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'LanguagesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
