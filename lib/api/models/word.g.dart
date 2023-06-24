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
      'wordId',
      serializers.serialize(object.wordId,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(WordType)),
      'subType',
      serializers.serialize(object.subType,
          specifiedType: const FullType(WordSubType)),
      'word',
      serializers.serialize(object.word, specifiedType: const FullType(String)),
      'imageList',
      serializers.serialize(object.imageList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
    value = object.keyStage;
    if (value != null) {
      result
        ..add('keyStage')
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
  Word deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'wordId':
          result.wordId = serializers.deserialize(value,
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
        case 'word':
          result.word = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'imageList':
          result.imageList.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
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
        case 'keyStage':
          result.keyStage = serializers.deserialize(value,
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

class _$Word extends Word {
  @override
  final String wordId;
  @override
  final DateTime? createdDate;
  @override
  final WordType type;
  @override
  final WordSubType subType;
  @override
  final String word;
  @override
  final BuiltList<String> imageList;
  @override
  final String sound;
  @override
  final bool? isFavourite;
  @override
  final double? usageCount;
  @override
  final double? keyStage;
  @override
  final bool? isUserAdded;
  @override
  final bool? isBackedUp;
  @override
  final BuiltList<String> extraRelatedWordIds;

  factory _$Word([void Function(WordBuilder)? updates]) =>
      (new WordBuilder()..update(updates))._build();

  _$Word._(
      {required this.wordId,
      this.createdDate,
      required this.type,
      required this.subType,
      required this.word,
      required this.imageList,
      required this.sound,
      this.isFavourite,
      this.usageCount,
      this.keyStage,
      this.isUserAdded,
      this.isBackedUp,
      required this.extraRelatedWordIds})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(wordId, r'Word', 'wordId');
    BuiltValueNullFieldError.checkNotNull(type, r'Word', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'Word', 'subType');
    BuiltValueNullFieldError.checkNotNull(word, r'Word', 'word');
    BuiltValueNullFieldError.checkNotNull(imageList, r'Word', 'imageList');
    BuiltValueNullFieldError.checkNotNull(sound, r'Word', 'sound');
    BuiltValueNullFieldError.checkNotNull(
        extraRelatedWordIds, r'Word', 'extraRelatedWordIds');
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
        wordId == other.wordId &&
        createdDate == other.createdDate &&
        type == other.type &&
        subType == other.subType &&
        word == other.word &&
        imageList == other.imageList &&
        sound == other.sound &&
        isFavourite == other.isFavourite &&
        usageCount == other.usageCount &&
        keyStage == other.keyStage &&
        isUserAdded == other.isUserAdded &&
        isBackedUp == other.isBackedUp &&
        extraRelatedWordIds == other.extraRelatedWordIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, wordId.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subType.hashCode);
    _$hash = $jc(_$hash, word.hashCode);
    _$hash = $jc(_$hash, imageList.hashCode);
    _$hash = $jc(_$hash, sound.hashCode);
    _$hash = $jc(_$hash, isFavourite.hashCode);
    _$hash = $jc(_$hash, usageCount.hashCode);
    _$hash = $jc(_$hash, keyStage.hashCode);
    _$hash = $jc(_$hash, isUserAdded.hashCode);
    _$hash = $jc(_$hash, isBackedUp.hashCode);
    _$hash = $jc(_$hash, extraRelatedWordIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Word')
          ..add('wordId', wordId)
          ..add('createdDate', createdDate)
          ..add('type', type)
          ..add('subType', subType)
          ..add('word', word)
          ..add('imageList', imageList)
          ..add('sound', sound)
          ..add('isFavourite', isFavourite)
          ..add('usageCount', usageCount)
          ..add('keyStage', keyStage)
          ..add('isUserAdded', isUserAdded)
          ..add('isBackedUp', isBackedUp)
          ..add('extraRelatedWordIds', extraRelatedWordIds))
        .toString();
  }
}

class WordBuilder implements Builder<Word, WordBuilder> {
  _$Word? _$v;

  String? _wordId;
  String? get wordId => _$this._wordId;
  set wordId(String? wordId) => _$this._wordId = wordId;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  WordType? _type;
  WordType? get type => _$this._type;
  set type(WordType? type) => _$this._type = type;

  WordSubType? _subType;
  WordSubType? get subType => _$this._subType;
  set subType(WordSubType? subType) => _$this._subType = subType;

  String? _word;
  String? get word => _$this._word;
  set word(String? word) => _$this._word = word;

  ListBuilder<String>? _imageList;
  ListBuilder<String> get imageList =>
      _$this._imageList ??= new ListBuilder<String>();
  set imageList(ListBuilder<String>? imageList) =>
      _$this._imageList = imageList;

  String? _sound;
  String? get sound => _$this._sound;
  set sound(String? sound) => _$this._sound = sound;

  bool? _isFavourite;
  bool? get isFavourite => _$this._isFavourite;
  set isFavourite(bool? isFavourite) => _$this._isFavourite = isFavourite;

  double? _usageCount;
  double? get usageCount => _$this._usageCount;
  set usageCount(double? usageCount) => _$this._usageCount = usageCount;

  double? _keyStage;
  double? get keyStage => _$this._keyStage;
  set keyStage(double? keyStage) => _$this._keyStage = keyStage;

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

  WordBuilder();

  WordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _wordId = $v.wordId;
      _createdDate = $v.createdDate;
      _type = $v.type;
      _subType = $v.subType;
      _word = $v.word;
      _imageList = $v.imageList.toBuilder();
      _sound = $v.sound;
      _isFavourite = $v.isFavourite;
      _usageCount = $v.usageCount;
      _keyStage = $v.keyStage;
      _isUserAdded = $v.isUserAdded;
      _isBackedUp = $v.isBackedUp;
      _extraRelatedWordIds = $v.extraRelatedWordIds.toBuilder();
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
              wordId: BuiltValueNullFieldError.checkNotNull(
                  wordId, r'Word', 'wordId'),
              createdDate: createdDate,
              type:
                  BuiltValueNullFieldError.checkNotNull(type, r'Word', 'type'),
              subType: BuiltValueNullFieldError.checkNotNull(
                  subType, r'Word', 'subType'),
              word:
                  BuiltValueNullFieldError.checkNotNull(word, r'Word', 'word'),
              imageList: imageList.build(),
              sound: BuiltValueNullFieldError.checkNotNull(
                  sound, r'Word', 'sound'),
              isFavourite: isFavourite,
              usageCount: usageCount,
              keyStage: keyStage,
              isUserAdded: isUserAdded,
              isBackedUp: isBackedUp,
              extraRelatedWordIds: extraRelatedWordIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageList';
        imageList.build();

        _$failedField = 'extraRelatedWordIds';
        extraRelatedWordIds.build();
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
          ..wordId = fields[0] as String
          ..createdDate = fields[1] as DateTime?
          ..type = fields[2] as WordType
          ..subType = fields[3] as WordSubType
          ..word = fields[4] as String
          ..imageList = fields[5] == null
              ? null
              : ListBuilder<String>(fields[5] as Iterable)
          ..sound = fields[6] as String
          ..isFavourite = fields[7] as bool?
          ..usageCount = fields[8] as double?
          ..keyStage = fields[9] as double?
          ..isUserAdded = fields[10] as bool?
          ..isBackedUp = fields[11] as bool?
          ..extraRelatedWordIds = fields[12] == null
              ? null
              : ListBuilder<String>(fields[12] as Iterable))
        .build();
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.wordId)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.subType)
      ..writeByte(4)
      ..write(obj.word)
      ..writeByte(5)
      ..write(obj.imageList.toList())
      ..writeByte(6)
      ..write(obj.sound)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(8)
      ..write(obj.usageCount)
      ..writeByte(9)
      ..write(obj.keyStage)
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
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
