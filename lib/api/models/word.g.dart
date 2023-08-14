// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Word> _$wordSerializer = new _$WordSerializer();

class _$WordSerializer implements StructuredSerializer<Word> {
  @override
  final Iterable<Type> types = const [Word, _$Word];
  @override
  final String wireName = 'Word';

  @override
  Iterable<Object?> serialize(Serializers serializers, Word object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'word',
      serializers.serialize(object.word, specifiedType: const FullType(String)),
      'imageId',
      serializers.serialize(object.imageId,
          specifiedType: const FullType(String)),
      'sound',
      serializers.serialize(object.sound,
          specifiedType: const FullType(String)),
      'extraRelatedWordIds',
      serializers.serialize(object.extraRelatedWordIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(WordType)),
      'subType',
      serializers.serialize(object.subType,
          specifiedType: const FullType(WordSubType)),
      'languageIds',
      serializers.serialize(object.languageIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.keyStage;
    if (value != null) {
      result
        ..add('keyStage')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.createdDate;
    if (value != null) {
      result
        ..add('createdDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.usageCount;
    if (value != null) {
      result
        ..add('usageCount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.isFavourite;
    if (value != null) {
      result
        ..add('isFavourite')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
  Word deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'word':
          result.word = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageId':
          result.imageId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'sound':
          result.sound = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'keyStage':
          result.keyStage = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'extraRelatedWordIds':
          result.extraRelatedWordIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(WordType))! as WordType;
          break;
        case 'subType':
          result.subType = serializers.deserialize(value,
              specifiedType: const FullType(WordSubType))! as WordSubType;
          break;
        case 'createdDate':
          result.createdDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'usageCount':
          result.usageCount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'isFavourite':
          result.isFavourite = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isUserAdded':
          result.isUserAdded = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isBackedUp':
          result.isBackedUp = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'languageIds':
          result.languageIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Word extends Word {
  @override
  final String word;
  @override
  final String imageId;
  @override
  final String sound;
  @override
  final double? keyStage;
  @override
  final BuiltList<String> extraRelatedWordIds;
  @override
  final String id;
  @override
  final WordType type;
  @override
  final WordSubType subType;
  @override
  final DateTime? createdDate;
  @override
  final double? usageCount;
  @override
  final bool? isFavourite;
  @override
  final bool? isUserAdded;
  @override
  final bool? isBackedUp;
  @override
  final BuiltList<String> languageIds;

  factory _$Word([void Function(WordBuilder)? updates]) =>
      (new WordBuilder()..update(updates))._build();

  _$Word._(
      {required this.word,
      required this.imageId,
      required this.sound,
      this.keyStage,
      required this.extraRelatedWordIds,
      required this.id,
      required this.type,
      required this.subType,
      this.createdDate,
      this.usageCount,
      this.isFavourite,
      this.isUserAdded,
      this.isBackedUp,
      required this.languageIds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(word, r'Word', 'word');
    BuiltValueNullFieldError.checkNotNull(imageId, r'Word', 'imageId');
    BuiltValueNullFieldError.checkNotNull(sound, r'Word', 'sound');
    BuiltValueNullFieldError.checkNotNull(
        extraRelatedWordIds, r'Word', 'extraRelatedWordIds');
    BuiltValueNullFieldError.checkNotNull(id, r'Word', 'id');
    BuiltValueNullFieldError.checkNotNull(type, r'Word', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'Word', 'subType');
    BuiltValueNullFieldError.checkNotNull(languageIds, r'Word', 'languageIds');
  }

  @override
  Word rebuild(void Function(WordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WordBuilder toBuilder() => new WordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Word &&
        word == other.word &&
        imageId == other.imageId &&
        sound == other.sound &&
        keyStage == other.keyStage &&
        extraRelatedWordIds == other.extraRelatedWordIds &&
        id == other.id &&
        type == other.type &&
        subType == other.subType &&
        createdDate == other.createdDate &&
        usageCount == other.usageCount &&
        isFavourite == other.isFavourite &&
        isUserAdded == other.isUserAdded &&
        isBackedUp == other.isBackedUp &&
        languageIds == other.languageIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, word.hashCode);
    _$hash = $jc(_$hash, imageId.hashCode);
    _$hash = $jc(_$hash, sound.hashCode);
    _$hash = $jc(_$hash, keyStage.hashCode);
    _$hash = $jc(_$hash, extraRelatedWordIds.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subType.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, usageCount.hashCode);
    _$hash = $jc(_$hash, isFavourite.hashCode);
    _$hash = $jc(_$hash, isUserAdded.hashCode);
    _$hash = $jc(_$hash, isBackedUp.hashCode);
    _$hash = $jc(_$hash, languageIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Word')
          ..add('word', word)
          ..add('imageId', imageId)
          ..add('sound', sound)
          ..add('keyStage', keyStage)
          ..add('extraRelatedWordIds', extraRelatedWordIds)
          ..add('id', id)
          ..add('type', type)
          ..add('subType', subType)
          ..add('createdDate', createdDate)
          ..add('usageCount', usageCount)
          ..add('isFavourite', isFavourite)
          ..add('isUserAdded', isUserAdded)
          ..add('isBackedUp', isBackedUp)
          ..add('languageIds', languageIds))
        .toString();
  }
}

class WordBuilder implements Builder<Word, WordBuilder> {
  _$Word? _$v;

  String? _word;
  String? get word => _$this._word;
  set word(String? word) => _$this._word = word;

  String? _imageId;
  String? get imageId => _$this._imageId;
  set imageId(String? imageId) => _$this._imageId = imageId;

  String? _sound;
  String? get sound => _$this._sound;
  set sound(String? sound) => _$this._sound = sound;

  double? _keyStage;
  double? get keyStage => _$this._keyStage;
  set keyStage(double? keyStage) => _$this._keyStage = keyStage;

  ListBuilder<String>? _extraRelatedWordIds;
  ListBuilder<String> get extraRelatedWordIds =>
      _$this._extraRelatedWordIds ??= new ListBuilder<String>();
  set extraRelatedWordIds(ListBuilder<String>? extraRelatedWordIds) =>
      _$this._extraRelatedWordIds = extraRelatedWordIds;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  WordType? _type;
  WordType? get type => _$this._type;
  set type(WordType? type) => _$this._type = type;

  WordSubType? _subType;
  WordSubType? get subType => _$this._subType;
  set subType(WordSubType? subType) => _$this._subType = subType;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  double? _usageCount;
  double? get usageCount => _$this._usageCount;
  set usageCount(double? usageCount) => _$this._usageCount = usageCount;

  bool? _isFavourite;
  bool? get isFavourite => _$this._isFavourite;
  set isFavourite(bool? isFavourite) => _$this._isFavourite = isFavourite;

  bool? _isUserAdded;
  bool? get isUserAdded => _$this._isUserAdded;
  set isUserAdded(bool? isUserAdded) => _$this._isUserAdded = isUserAdded;

  bool? _isBackedUp;
  bool? get isBackedUp => _$this._isBackedUp;
  set isBackedUp(bool? isBackedUp) => _$this._isBackedUp = isBackedUp;

  ListBuilder<String>? _languageIds;
  ListBuilder<String> get languageIds =>
      _$this._languageIds ??= new ListBuilder<String>();
  set languageIds(ListBuilder<String>? languageIds) =>
      _$this._languageIds = languageIds;

  WordBuilder();

  WordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _word = $v.word;
      _imageId = $v.imageId;
      _sound = $v.sound;
      _keyStage = $v.keyStage;
      _extraRelatedWordIds = $v.extraRelatedWordIds.toBuilder();
      _id = $v.id;
      _type = $v.type;
      _subType = $v.subType;
      _createdDate = $v.createdDate;
      _usageCount = $v.usageCount;
      _isFavourite = $v.isFavourite;
      _isUserAdded = $v.isUserAdded;
      _isBackedUp = $v.isBackedUp;
      _languageIds = $v.languageIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Word other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Word;
  }

  @override
  void update(void Function(WordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Word build() => _build();

  _$Word _build() {
    _$Word _$result;
    try {
      _$result = _$v ??
          new _$Word._(
              word:
                  BuiltValueNullFieldError.checkNotNull(word, r'Word', 'word'),
              imageId: BuiltValueNullFieldError.checkNotNull(
                  imageId, r'Word', 'imageId'),
              sound: BuiltValueNullFieldError.checkNotNull(
                  sound, r'Word', 'sound'),
              keyStage: keyStage,
              extraRelatedWordIds: extraRelatedWordIds.build(),
              id: BuiltValueNullFieldError.checkNotNull(id, r'Word', 'id'),
              type:
                  BuiltValueNullFieldError.checkNotNull(type, r'Word', 'type'),
              subType: BuiltValueNullFieldError.checkNotNull(
                  subType, r'Word', 'subType'),
              createdDate: createdDate,
              usageCount: usageCount,
              isFavourite: isFavourite,
              isUserAdded: isUserAdded,
              isBackedUp: isBackedUp,
              languageIds: languageIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'extraRelatedWordIds';
        extraRelatedWordIds.build();

        _$failedField = 'languageIds';
        languageIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Word', _$failedField, e.toString());
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

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 1;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (WordBuilder()
          ..word = fields[9] as String
          ..imageId = fields[10] as String
          ..sound = fields[11] as String
          ..keyStage = fields[12] as double?
          ..extraRelatedWordIds = fields[14] == null
              ? null
              : ListBuilder<String>(fields[14] as Iterable)
          ..id = fields[0] as String
          ..type = fields[1] as WordType
          ..subType = fields[2] as WordSubType
          ..createdDate = fields[3] as DateTime?
          ..usageCount = fields[4] as double?
          ..isFavourite = fields[5] as bool?
          ..isUserAdded = fields[6] as bool?
          ..isBackedUp = fields[7] as bool?
          ..languageIds = fields[8] == null
              ? null
              : ListBuilder<String>(fields[8] as Iterable))
        .build();
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(14)
      ..writeByte(9)
      ..write(obj.word)
      ..writeByte(10)
      ..write(obj.imageId)
      ..writeByte(11)
      ..write(obj.sound)
      ..writeByte(12)
      ..write(obj.keyStage)
      ..writeByte(14)
      ..write(obj.extraRelatedWordIds.toList())
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.subType)
      ..writeByte(3)
      ..write(obj.createdDate)
      ..writeByte(4)
      ..write(obj.usageCount)
      ..writeByte(5)
      ..write(obj.isFavourite)
      ..writeByte(6)
      ..write(obj.isUserAdded)
      ..writeByte(7)
      ..write(obj.isBackedUp)
      ..writeByte(8)
      ..write(obj.languageIds.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
