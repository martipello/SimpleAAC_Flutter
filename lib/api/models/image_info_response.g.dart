// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_info_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ImageInfoResponse> _$imageInfoResponseSerializer =
    new _$ImageInfoResponseSerializer();

class _$ImageInfoResponseSerializer
    implements StructuredSerializer<ImageInfoResponse> {
  @override
  final Iterable<Type> types = const [ImageInfoResponse, _$ImageInfoResponse];
  @override
  final String wireName = 'ImageInfoResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, ImageInfoResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'imageInfos',
      serializers.serialize(object.imageInfos,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ImageInfo)])),
    ];

    return result;
  }

  @override
  ImageInfoResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImageInfoResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'imageInfos':
          result.imageInfos.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ImageInfo)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ImageInfoResponse extends ImageInfoResponse {
  @override
  final BuiltList<ImageInfo> imageInfos;

  factory _$ImageInfoResponse(
          [void Function(ImageInfoResponseBuilder)? updates]) =>
      (new ImageInfoResponseBuilder()..update(updates))._build();

  _$ImageInfoResponse._({required this.imageInfos}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        imageInfos, r'ImageInfoResponse', 'imageInfos');
  }

  @override
  ImageInfoResponse rebuild(void Function(ImageInfoResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageInfoResponseBuilder toBuilder() =>
      new ImageInfoResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ImageInfoResponse && imageInfos == other.imageInfos;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, imageInfos.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ImageInfoResponse')
          ..add('imageInfos', imageInfos))
        .toString();
  }
}

class ImageInfoResponseBuilder
    implements Builder<ImageInfoResponse, ImageInfoResponseBuilder> {
  _$ImageInfoResponse? _$v;

  ListBuilder<ImageInfo>? _imageInfos;
  ListBuilder<ImageInfo> get imageInfos =>
      _$this._imageInfos ??= new ListBuilder<ImageInfo>();
  set imageInfos(ListBuilder<ImageInfo>? imageInfos) =>
      _$this._imageInfos = imageInfos;

  ImageInfoResponseBuilder();

  ImageInfoResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageInfos = $v.imageInfos.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ImageInfoResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ImageInfoResponse;
  }

  @override
  void update(void Function(ImageInfoResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ImageInfoResponse build() => _build();

  _$ImageInfoResponse _build() {
    _$ImageInfoResponse _$result;
    try {
      _$result =
          _$v ?? new _$ImageInfoResponse._(imageInfos: imageInfos.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'imageInfos';
        imageInfos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'ImageInfoResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
