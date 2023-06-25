// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Language> _$languageSerializer = new _$LanguageSerializer();

class _$LanguageSerializer implements StructuredSerializer<Language> {
  @override
  final Iterable<Type> types = const [Language, _$Language];
  @override
  final String wireName = 'Language';

  @override
  Iterable<Object?> serialize(Serializers serializers, Language object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'words',
      serializers.serialize(object.words,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Word)])),
      'sentences',
      serializers.serialize(object.sentences,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Sentence)])),
      'wordGroups',
      serializers.serialize(object.wordGroups,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WordGroup)])),
    ];

    return result;
  }

  @override
  Language deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LanguageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'words':
          result.words.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Word)]))!
              as BuiltList<Object?>);
          break;
        case 'sentences':
          result.sentences.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Sentence)]))!
              as BuiltList<Object?>);
          break;
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

class _$Language extends Language {
  @override
  final String id;
  @override
  final String displayName;
  @override
  final BuiltList<Word> words;
  @override
  final BuiltList<Sentence> sentences;
  @override
  final BuiltList<WordGroup> wordGroups;

  factory _$Language([void Function(LanguageBuilder)? updates]) =>
      (new LanguageBuilder()..update(updates))._build();

  _$Language._(
      {required this.id,
      required this.displayName,
      required this.words,
      required this.sentences,
      required this.wordGroups})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Language', 'id');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'Language', 'displayName');
    BuiltValueNullFieldError.checkNotNull(words, r'Language', 'words');
    BuiltValueNullFieldError.checkNotNull(sentences, r'Language', 'sentences');
    BuiltValueNullFieldError.checkNotNull(
        wordGroups, r'Language', 'wordGroups');
  }

  @override
  Language rebuild(void Function(LanguageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LanguageBuilder toBuilder() => new LanguageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Language &&
        id == other.id &&
        displayName == other.displayName &&
        words == other.words &&
        sentences == other.sentences &&
        wordGroups == other.wordGroups;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, words.hashCode);
    _$hash = $jc(_$hash, sentences.hashCode);
    _$hash = $jc(_$hash, wordGroups.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Language')
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('words', words)
          ..add('sentences', sentences)
          ..add('wordGroups', wordGroups))
        .toString();
  }
}

class LanguageBuilder implements Builder<Language, LanguageBuilder> {
  _$Language? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  ListBuilder<Word>? _words;
  ListBuilder<Word> get words => _$this._words ??= new ListBuilder<Word>();
  set words(ListBuilder<Word>? words) => _$this._words = words;

  ListBuilder<Sentence>? _sentences;
  ListBuilder<Sentence> get sentences =>
      _$this._sentences ??= new ListBuilder<Sentence>();
  set sentences(ListBuilder<Sentence>? sentences) =>
      _$this._sentences = sentences;

  ListBuilder<WordGroup>? _wordGroups;
  ListBuilder<WordGroup> get wordGroups =>
      _$this._wordGroups ??= new ListBuilder<WordGroup>();
  set wordGroups(ListBuilder<WordGroup>? wordGroups) =>
      _$this._wordGroups = wordGroups;

  LanguageBuilder();

  LanguageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _displayName = $v.displayName;
      _words = $v.words.toBuilder();
      _sentences = $v.sentences.toBuilder();
      _wordGroups = $v.wordGroups.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Language other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Language;
  }

  @override
  void update(void Function(LanguageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Language build() => _build();

  _$Language _build() {
    _$Language _$result;
    try {
      _$result = _$v ??
          new _$Language._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'Language', 'id'),
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'Language', 'displayName'),
              words: words.build(),
              sentences: sentences.build(),
              wordGroups: wordGroups.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'words';
        words.build();
        _$failedField = 'sentences';
        sentences.build();
        _$failedField = 'wordGroups';
        wordGroups.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Language', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  final int typeId = 0;

  @override
  Language read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (LanguageBuilder()
          ..id = fields[0] as String
          ..displayName = fields[1] as String
          ..words = fields[2] == null
              ? null
              : ListBuilder<Word>(fields[2] as Iterable)
          ..sentences = fields[3] == null
              ? null
              : ListBuilder<Sentence>(fields[3] as Iterable)
          ..wordGroups = fields[4] == null
              ? null
              : ListBuilder<WordGroup>(fields[4] as Iterable))
        .build();
  }

  @override
  void write(BinaryWriter writer, Language obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.words.toList())
      ..writeByte(3)
      ..write(obj.sentences.toList())
      ..writeByte(4)
      ..write(obj.wordGroups.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
