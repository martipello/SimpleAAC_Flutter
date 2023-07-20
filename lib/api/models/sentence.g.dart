// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Sentence> _$sentenceSerializer = new _$SentenceSerializer();

class _$SentenceSerializer implements StructuredSerializer<Sentence> {
  @override
  final Iterable<Type> types = const [Sentence, _$Sentence];
  @override
  final String wireName = 'Sentence';

  @override
  Iterable<Object?> serialize(Serializers serializers, Sentence object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(WordType)),
      'subType',
      serializers.serialize(object.subType,
          specifiedType: const FullType(WordSubType)),
      'words',
      serializers.serialize(object.words,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Word)])),
      'sound',
      serializers.serialize(object.sound,
          specifiedType: const FullType(String)),
      'extraRelatedWordIds',
      serializers.serialize(object.extraRelatedWordIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.createdDate;
    if (value != null) {
      result
        ..add('createdDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.isFavourite;
    if (value != null) {
      result
        ..add('isFavourite')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.usageCount;
    if (value != null) {
      result
        ..add('usageCount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.isUserAdded;
    if (value != null) {
      result
        ..add('isUserAdded')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isBackedUp;
    if (value != null) {
      result
        ..add('isBackedUp')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  Sentence deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SentenceBuilder();

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
        case 'createdDate':
          result.createdDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(WordType))! as WordType;
          break;
        case 'subType':
          result.subType = serializers.deserialize(value,
              specifiedType: const FullType(WordSubType))! as WordSubType;
          break;
        case 'words':
          result.words.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Word)]))!
              as BuiltList<Object?>);
          break;
        case 'sound':
          result.sound = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'isFavourite':
          result.isFavourite = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'usageCount':
          result.usageCount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'isUserAdded':
          result.isUserAdded = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isBackedUp':
          result.isBackedUp = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'extraRelatedWordIds':
          result.extraRelatedWordIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Sentence extends Sentence {
  @override
  final String id;
  @override
  final DateTime? createdDate;
  @override
  final WordType type;
  @override
  final WordSubType subType;
  @override
  final BuiltList<Word> words;
  @override
  final String sound;
  @override
  final bool? isFavourite;
  @override
  final double? usageCount;
  @override
  final bool? isUserAdded;
  @override
  final bool? isBackedUp;
  @override
  final BuiltList<String> extraRelatedWordIds;

  factory _$Sentence([void Function(SentenceBuilder)? updates]) =>
      (new SentenceBuilder()..update(updates))._build();

  _$Sentence._(
      {required this.id,
      this.createdDate,
      required this.type,
      required this.subType,
      required this.words,
      required this.sound,
      this.isFavourite,
      this.usageCount,
      this.isUserAdded,
      this.isBackedUp,
      required this.extraRelatedWordIds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Sentence', 'id');
    BuiltValueNullFieldError.checkNotNull(type, r'Sentence', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'Sentence', 'subType');
    BuiltValueNullFieldError.checkNotNull(words, r'Sentence', 'words');
    BuiltValueNullFieldError.checkNotNull(sound, r'Sentence', 'sound');
    BuiltValueNullFieldError.checkNotNull(
        extraRelatedWordIds, r'Sentence', 'extraRelatedWordIds');
  }

  @override
  Sentence rebuild(void Function(SentenceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SentenceBuilder toBuilder() => new SentenceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sentence &&
        id == other.id &&
        createdDate == other.createdDate &&
        type == other.type &&
        subType == other.subType &&
        words == other.words &&
        sound == other.sound &&
        isFavourite == other.isFavourite &&
        usageCount == other.usageCount &&
        isUserAdded == other.isUserAdded &&
        isBackedUp == other.isBackedUp &&
        extraRelatedWordIds == other.extraRelatedWordIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subType.hashCode);
    _$hash = $jc(_$hash, words.hashCode);
    _$hash = $jc(_$hash, sound.hashCode);
    _$hash = $jc(_$hash, isFavourite.hashCode);
    _$hash = $jc(_$hash, usageCount.hashCode);
    _$hash = $jc(_$hash, isUserAdded.hashCode);
    _$hash = $jc(_$hash, isBackedUp.hashCode);
    _$hash = $jc(_$hash, extraRelatedWordIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Sentence')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('type', type)
          ..add('subType', subType)
          ..add('words', words)
          ..add('sound', sound)
          ..add('isFavourite', isFavourite)
          ..add('usageCount', usageCount)
          ..add('isUserAdded', isUserAdded)
          ..add('isBackedUp', isBackedUp)
          ..add('extraRelatedWordIds', extraRelatedWordIds))
        .toString();
  }
}

class SentenceBuilder implements Builder<Sentence, SentenceBuilder> {
  _$Sentence? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  WordType? _type;
  WordType? get type => _$this._type;
  set type(WordType? type) => _$this._type = type;

  WordSubType? _subType;
  WordSubType? get subType => _$this._subType;
  set subType(WordSubType? subType) => _$this._subType = subType;

  ListBuilder<Word>? _words;
  ListBuilder<Word> get words => _$this._words ??= new ListBuilder<Word>();
  set words(ListBuilder<Word>? words) => _$this._words = words;

  String? _sound;
  String? get sound => _$this._sound;
  set sound(String? sound) => _$this._sound = sound;

  bool? _isFavourite;
  bool? get isFavourite => _$this._isFavourite;
  set isFavourite(bool? isFavourite) => _$this._isFavourite = isFavourite;

  double? _usageCount;
  double? get usageCount => _$this._usageCount;
  set usageCount(double? usageCount) => _$this._usageCount = usageCount;

  bool? _isUserAdded;
  bool? get isUserAdded => _$this._isUserAdded;
  set isUserAdded(bool? isUserAdded) => _$this._isUserAdded = isUserAdded;

  bool? _isBackedUp;
  bool? get isBackedUp => _$this._isBackedUp;
  set isBackedUp(bool? isBackedUp) => _$this._isBackedUp = isBackedUp;

  ListBuilder<String>? _extraRelatedWordIds;
  ListBuilder<String> get extraRelatedWordIds =>
      _$this._extraRelatedWordIds ??= new ListBuilder<String>();
  set extraRelatedWordIds(ListBuilder<String>? extraRelatedWordIds) =>
      _$this._extraRelatedWordIds = extraRelatedWordIds;

  SentenceBuilder();

  SentenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _type = $v.type;
      _subType = $v.subType;
      _words = $v.words.toBuilder();
      _sound = $v.sound;
      _isFavourite = $v.isFavourite;
      _usageCount = $v.usageCount;
      _isUserAdded = $v.isUserAdded;
      _isBackedUp = $v.isBackedUp;
      _extraRelatedWordIds = $v.extraRelatedWordIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Sentence other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Sentence;
  }

  @override
  void update(void Function(SentenceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Sentence build() => _build();

  _$Sentence _build() {
    _$Sentence _$result;
    try {
      _$result = _$v ??
          new _$Sentence._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'Sentence', 'id'),
              createdDate: createdDate,
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'Sentence', 'type'),
              subType: BuiltValueNullFieldError.checkNotNull(
                  subType, r'Sentence', 'subType'),
              words: words.build(),
              sound: BuiltValueNullFieldError.checkNotNull(
                  sound, r'Sentence', 'sound'),
              isFavourite: isFavourite,
              usageCount: usageCount,
              isUserAdded: isUserAdded,
              isBackedUp: isBackedUp,
              extraRelatedWordIds: extraRelatedWordIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'words';
        words.build();

        _$failedField = 'extraRelatedWordIds';
        extraRelatedWordIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Sentence', _$failedField, e.toString());
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

class SentenceAdapter extends TypeAdapter<Sentence> {
  @override
  final int typeId = 4;

  @override
  Sentence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (SentenceBuilder()
          ..id = fields[0] as String
          ..createdDate = fields[1] as DateTime?
          ..type = fields[2] as WordType
          ..subType = fields[3] as WordSubType
          ..words = fields[4] == null
              ? null
              : ListBuilder<Word>(fields[4] as Iterable)
          ..sound = fields[6] as String
          ..isFavourite = fields[7] as bool?
          ..usageCount = fields[8] as double?
          ..isUserAdded = fields[10] as bool?
          ..isBackedUp = fields[11] as bool?
          ..extraRelatedWordIds = fields[12] == null
              ? null
              : ListBuilder<String>(fields[12] as Iterable))
        .build();
  }

  @override
  void write(BinaryWriter writer, Sentence obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.subType)
      ..writeByte(4)
      ..write(obj.words.toList())
      ..writeByte(6)
      ..write(obj.sound)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(8)
      ..write(obj.usageCount)
      ..writeByte(10)
      ..write(obj.isUserAdded)
      ..writeByte(11)
      ..write(obj.isBackedUp)
      ..writeByte(12)
      ..write(obj.extraRelatedWordIds.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SentenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
