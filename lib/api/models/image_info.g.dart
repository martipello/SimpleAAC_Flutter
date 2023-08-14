// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ImageInfo> _$imageInfoSerializer = new _$ImageInfoSerializer();

class _$ImageInfoSerializer implements StructuredSerializer<ImageInfo> {
  @override
  final Iterable<Type> types = const [ImageInfo, _$ImageInfo];
  @override
  final String wireName = 'ImageInfo';

  @override
  Iterable<Object?> serialize(Serializers serializers, ImageInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'uri',
      serializers.serialize(object.uri, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ImageInfo deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImageInfoBuilder();

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
        case 'uri':
          result.uri = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ImageInfo extends ImageInfo {
  @override
  final String id;
  @override
  final String uri;

  factory _$ImageInfo([void Function(ImageInfoBuilder)? updates]) =>
      (new ImageInfoBuilder()..update(updates))._build();

  _$ImageInfo._({required this.id, required this.uri}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'ImageInfo', 'id');
    BuiltValueNullFieldError.checkNotNull(uri, r'ImageInfo', 'uri');
  }

  @override
  ImageInfo rebuild(void Function(ImageInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageInfoBuilder toBuilder() => new ImageInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageInfo && id == other.id && uri == other.uri;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, uri.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImageInfo')
          ..add('id', id)
          ..add('uri', uri))
        .toString();
  }
}

class ImageInfoBuilder implements Builder<ImageInfo, ImageInfoBuilder> {
  _$ImageInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _uri;
  String? get uri => _$this._uri;
  set uri(String? uri) => _$this._uri = uri;

  ImageInfoBuilder();

  ImageInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _uri = $v.uri;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageInfo other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImageInfo;
  }

  @override
  void update(void Function(ImageInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImageInfo build() => _build();

  _$ImageInfo _build() {
    final _$result = _$v ??
        new _$ImageInfo._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'ImageInfo', 'id'),
            uri: BuiltValueNullFieldError.checkNotNull(
                uri, r'ImageInfo', 'uri'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageInfoAdapter extends TypeAdapter<ImageInfo> {
  @override
  final int typeId = 9;

  @override
  ImageInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (ImageInfoBuilder()
          ..id = fields[0] as String
          ..uri = fields[1] as String)
        .build();
  }

  @override
  void write(BinaryWriter writer, ImageInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
