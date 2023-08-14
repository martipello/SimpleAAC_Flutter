//ignore_for_file: prefer_final_parameters
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';

part 'image_info.g.dart';

@HiveType(typeId: 9)
abstract class ImageInfo implements Built<ImageInfo, ImageInfoBuilder> {

  factory ImageInfo([void Function(ImageInfoBuilder) updates]) = _$ImageInfo;
  ImageInfo._();

  @HiveField(0)
  String get id;

  @HiveField(1)
  String get uri;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ImageInfo.serializer, this) as Map<String, dynamic>;
  }

  static ImageInfo fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(ImageInfo.serializer, json)!;
  }

  static Serializer<ImageInfo> get serializer => _$imageInfoSerializer;
}