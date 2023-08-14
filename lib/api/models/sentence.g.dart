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
      'wordIds',
      serializers.serialize(object.wordIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
  Sentence deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SentenceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'wordIds':
          result.wordIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$Sentence extends Sentence {
  @override
  final BuiltList<String> wordIds;
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

  factory _$Sentence([void Function(SentenceBuilder)? updates]) =>
      (new SentenceBuilder()..update(updates))._build();

  _$Sentence._(
      {required this.wordIds,
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
    BuiltValueNullFieldError.checkNotNull(wordIds, r'Sentence', 'wordIds');
    BuiltValueNullFieldError.checkNotNull(
        extraRelatedWordIds, r'Sentence', 'extraRelatedWordIds');
    BuiltValueNullFieldError.checkNotNull(id, r'Sentence', 'id');
    BuiltValueNullFieldError.checkNotNull(type, r'Sentence', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'Sentence', 'subType');
    BuiltValueNullFieldError.checkNotNull(
        languageIds, r'Sentence', 'languageIds');
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
        wordIds == other.wordIds &&
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
    _$hash = $jc(_$hash, wordIds.hashCode);
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
    return (newBuiltValueToStringHelper(r'Sentence')
          ..add('wordIds', wordIds)
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

class SentenceBuilder implements Builder<Sentence, SentenceBuilder> {
  _$Sentence? _$v;

  ListBuilder<String>? _wordIds;
  ListBuilder<String> get wordIds =>
      _$this._wordIds ??= new ListBuilder<String>();
  set wordIds(ListBuilder<String>? wordIds) => _$this._wordIds = wordIds;

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

  SentenceBuilder();

  SentenceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _wordIds = $v.wordIds.toBuilder();
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
              wordIds: wordIds.build(),
              extraRelatedWordIds: extraRelatedWordIds.build(),
              id: BuiltValueNullFieldError.checkNotNull(id, r'Sentence', 'id'),
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'Sentence', 'type'),
              subType: BuiltValueNullFieldError.checkNotNull(
                  subType, r'Sentence', 'subType'),
              createdDate: createdDate,
              usageCount: usageCount,
              isFavourite: isFavourite,
              isUserAdded: isUserAdded,
              isBackedUp: isBackedUp,
              languageIds: languageIds.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'wordIds';
        wordIds.build();
        _$failedField = 'extraRelatedWordIds';
        extraRelatedWordIds.build();

        _$failedField = 'languageIds';
        languageIds.build();
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
  final int typeId = 2;

  @override
  Sentence read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (SentenceBuilder()
          ..wordIds = fields[9] == null
              ? null
              : ListBuilder<String>(fields[9] as Iterable)
          ..extraRelatedWordIds = fields[10] == null
              ? null
              : ListBuilder<String>(fields[10] as Iterable)
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
  void write(BinaryWriter writer, Sentence obj) {
    writer
      ..writeByte(11)
      ..writeByte(9)
      ..write(obj.wordIds.toList())
      ..writeByte(10)
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
      other is SentenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
