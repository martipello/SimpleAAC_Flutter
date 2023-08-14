// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_group.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WordGroup> _$wordGroupSerializer = new _$WordGroupSerializer();

class _$WordGroupSerializer implements StructuredSerializer<WordGroup> {
  @override
  final Iterable<Type> types = const [WordGroup, _$WordGroup];
  @override
  final String wireName = 'WordGroup';

  @override
  Iterable<Object?> serialize(Serializers serializers, WordGroup object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'wordIds',
      serializers.serialize(object.wordIds,
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
  WordGroup deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WordGroupBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'wordIds':
          result.wordIds.replace(serializers.deserialize(value,
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

class _$WordGroup extends WordGroup {
  @override
  final String displayName;
  @override
  final BuiltList<String> wordIds;
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

  factory _$WordGroup([void Function(WordGroupBuilder)? updates]) =>
      (new WordGroupBuilder()..update(updates))._build();

  _$WordGroup._(
      {required this.displayName,
      required this.wordIds,
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
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'WordGroup', 'displayName');
    BuiltValueNullFieldError.checkNotNull(wordIds, r'WordGroup', 'wordIds');
    BuiltValueNullFieldError.checkNotNull(id, r'WordGroup', 'id');
    BuiltValueNullFieldError.checkNotNull(type, r'WordGroup', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'WordGroup', 'subType');
    BuiltValueNullFieldError.checkNotNull(
        languageIds, r'WordGroup', 'languageIds');
  }

  @override
  WordGroup rebuild(void Function(WordGroupBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WordGroupBuilder toBuilder() => new WordGroupBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WordGroup &&
        displayName == other.displayName &&
        wordIds == other.wordIds &&
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
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, wordIds.hashCode);
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
    return (newBuiltValueToStringHelper(r'WordGroup')
          ..add('displayName', displayName)
          ..add('wordIds', wordIds)
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

class WordGroupBuilder implements Builder<WordGroup, WordGroupBuilder> {
  _$WordGroup? _$v;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  ListBuilder<String>? _wordIds;
  ListBuilder<String> get wordIds =>
      _$this._wordIds ??= new ListBuilder<String>();
  set wordIds(ListBuilder<String>? wordIds) => _$this._wordIds = wordIds;

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

  WordGroupBuilder();

  WordGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _displayName = $v.displayName;
      _wordIds = $v.wordIds.toBuilder();
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
  void replace(WordGroup other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WordGroup;
  }

  @override
  void update(void Function(WordGroupBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WordGroup build() => _build();

  _$WordGroup _build() {
    _$WordGroup _$result;
    try {
      _$result = _$v ??
          new _$WordGroup._(
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'WordGroup', 'displayName'),
              wordIds: wordIds.build(),
              id: BuiltValueNullFieldError.checkNotNull(id, r'WordGroup', 'id'),
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'WordGroup', 'type'),
              subType: BuiltValueNullFieldError.checkNotNull(
                  subType, r'WordGroup', 'subType'),
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

        _$failedField = 'languageIds';
        languageIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WordGroup', _$failedField, e.toString());
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

class WordGroupAdapter extends TypeAdapter<WordGroup> {
  @override
  final int typeId = 3;

  @override
  WordGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (WordGroupBuilder()
          ..displayName = fields[9] as String
          ..wordIds = fields[10] == null
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
  void write(BinaryWriter writer, WordGroup obj) {
    writer
      ..writeByte(11)
      ..writeByte(9)
      ..write(obj.displayName)
      ..writeByte(10)
      ..write(obj.wordIds.toList())
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
      other is WordGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
