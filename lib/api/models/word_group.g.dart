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
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'displayName',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(WordType)),
      'subType',
      serializers.serialize(object.subType,
          specifiedType: const FullType(WordSubType)),
      'words',
      serializers.serialize(object.words,
          specifiedType:
              const FullType(BuiltList, const [const FullType(WordBase)])),
    ];
    Object? value;
    value = object.createdDate;
    if (value != null) {
      result
        ..add('createdDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.isBackedUp;
    if (value != null) {
      result
        ..add('isBackedUp')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
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
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(WordBase)]))!
              as BuiltList<Object?>);
          break;
        case 'isBackedUp':
          result.isBackedUp = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isFavourite':
          result.isFavourite = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'usageCount':
          result.usageCount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$WordGroup extends WordGroup {
  @override
  final String id;
  @override
  final String displayName;
  @override
  final DateTime? createdDate;
  @override
  final WordType type;
  @override
  final WordSubType subType;
  @override
  final BuiltList<WordBase> words;
  @override
  final bool? isBackedUp;
  @override
  final bool? isFavourite;
  @override
  final double? usageCount;

  factory _$WordGroup([void Function(WordGroupBuilder)? updates]) =>
      (new WordGroupBuilder()..update(updates))._build();

  _$WordGroup._(
      {required this.id,
      required this.displayName,
      this.createdDate,
      required this.type,
      required this.subType,
      required this.words,
      this.isBackedUp,
      this.isFavourite,
      this.usageCount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'WordGroup', 'id');
    BuiltValueNullFieldError.checkNotNull(
        displayName, r'WordGroup', 'displayName');
    BuiltValueNullFieldError.checkNotNull(type, r'WordGroup', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'WordGroup', 'subType');
    BuiltValueNullFieldError.checkNotNull(words, r'WordGroup', 'words');
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
        id == other.id &&
        displayName == other.displayName &&
        createdDate == other.createdDate &&
        type == other.type &&
        subType == other.subType &&
        words == other.words &&
        isBackedUp == other.isBackedUp &&
        isFavourite == other.isFavourite &&
        usageCount == other.usageCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, createdDate.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, subType.hashCode);
    _$hash = $jc(_$hash, words.hashCode);
    _$hash = $jc(_$hash, isBackedUp.hashCode);
    _$hash = $jc(_$hash, isFavourite.hashCode);
    _$hash = $jc(_$hash, usageCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WordGroup')
          ..add('id', id)
          ..add('displayName', displayName)
          ..add('createdDate', createdDate)
          ..add('type', type)
          ..add('subType', subType)
          ..add('words', words)
          ..add('isBackedUp', isBackedUp)
          ..add('isFavourite', isFavourite)
          ..add('usageCount', usageCount))
        .toString();
  }
}

class WordGroupBuilder implements Builder<WordGroup, WordGroupBuilder> {
  _$WordGroup? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  WordType? _type;
  WordType? get type => _$this._type;
  set type(WordType? type) => _$this._type = type;

  WordSubType? _subType;
  WordSubType? get subType => _$this._subType;
  set subType(WordSubType? subType) => _$this._subType = subType;

  ListBuilder<WordBase>? _words;
  ListBuilder<WordBase> get words =>
      _$this._words ??= new ListBuilder<WordBase>();
  set words(ListBuilder<WordBase>? words) => _$this._words = words;

  bool? _isBackedUp;
  bool? get isBackedUp => _$this._isBackedUp;
  set isBackedUp(bool? isBackedUp) => _$this._isBackedUp = isBackedUp;

  bool? _isFavourite;
  bool? get isFavourite => _$this._isFavourite;
  set isFavourite(bool? isFavourite) => _$this._isFavourite = isFavourite;

  double? _usageCount;
  double? get usageCount => _$this._usageCount;
  set usageCount(double? usageCount) => _$this._usageCount = usageCount;

  WordGroupBuilder();

  WordGroupBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _displayName = $v.displayName;
      _createdDate = $v.createdDate;
      _type = $v.type;
      _subType = $v.subType;
      _words = $v.words.toBuilder();
      _isBackedUp = $v.isBackedUp;
      _isFavourite = $v.isFavourite;
      _usageCount = $v.usageCount;
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
              id: BuiltValueNullFieldError.checkNotNull(id, r'WordGroup', 'id'),
              displayName: BuiltValueNullFieldError.checkNotNull(
                  displayName, r'WordGroup', 'displayName'),
              createdDate: createdDate,
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'WordGroup', 'type'),
              subType: BuiltValueNullFieldError.checkNotNull(
                  subType, r'WordGroup', 'subType'),
              words: words.build(),
              isBackedUp: isBackedUp,
              isFavourite: isFavourite,
              usageCount: usageCount);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'words';
        words.build();
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
  final int typeId = 5;

  @override
  WordGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (WordGroupBuilder()
          ..id = fields[0] as String
          ..displayName = fields[1] as String
          ..createdDate = fields[2] as DateTime?
          ..type = fields[3] as WordType
          ..subType = fields[4] as WordSubType
          ..words = fields[5] == null
              ? null
              : ListBuilder<WordBase>(fields[5] as Iterable)
          ..isBackedUp = fields[6] as bool?
          ..isFavourite = fields[7] as bool?
          ..usageCount = fields[8] as double?)
        .build();
  }

  @override
  void write(BinaryWriter writer, WordGroup obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.createdDate)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.subType)
      ..writeByte(5)
      ..write(obj.words.toList())
      ..writeByte(6)
      ..write(obj.isBackedUp)
      ..writeByte(7)
      ..write(obj.isFavourite)
      ..writeByte(8)
      ..write(obj.usageCount);
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
