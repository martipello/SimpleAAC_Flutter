//ignore_for_file: prefer_final_parameters

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers/serializers.dart';
import 'image_info.dart';

part 'image_info_response.g.dart';

abstract class ImageInfoResponse implements Built<ImageInfoResponse, ImageInfoResponseBuilder> {

  factory ImageInfoResponse([void Function(ImageInfoResponseBuilder) updates]) = _$ImageInfoResponse;
  ImageInfoResponse._();

  BuiltList<ImageInfo> get imageInfos;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ImageInfoResponse.serializer, this) as Map<String, dynamic>;
  }

  static ImageInfoResponse fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(ImageInfoResponse.serializer, json)!;
  }

  static Serializer<ImageInfoResponse> get serializer => _$imageInfoResponseSerializer;
}