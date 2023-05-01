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
      'predictionList',
      serializers.serialize(object.predictionList,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Word)])),
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
        case 'predictionList':
          result.predictionList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Word)]))!
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
  final BuiltList<Word> predictionList;

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
      required this.predictionList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(wordId, r'Word', 'wordId');
    BuiltValueNullFieldError.checkNotNull(type, r'Word', 'type');
    BuiltValueNullFieldError.checkNotNull(subType, r'Word', 'subType');
    BuiltValueNullFieldError.checkNotNull(word, r'Word', 'word');
    BuiltValueNullFieldError.checkNotNull(imageList, r'Word', 'imageList');
    BuiltValueNullFieldError.checkNotNull(sound, r'Word', 'sound');
    BuiltValueNullFieldError.checkNotNull(
        predictionList, r'Word', 'predictionList');
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
        predictionList == other.predictionList;
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
    _$hash = $jc(_$hash, predictionList.hashCode);
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
          ..add('predictionList', predictionList))
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

  ListBuilder<Word>? _predictionList;
  ListBuilder<Word> get predictionList =>
      _$this._predictionList ??= new ListBuilder<Word>();
  set predictionList(ListBuilder<Word>? predictionList) =>
      _$this._predictionList = predictionList;

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
      _predictionList = $v.predictionList.toBuilder();
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
              predictionList: predictionList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageList';
        imageList.build();

        _$failedField = 'predictionList';
        predictionList.build();
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
