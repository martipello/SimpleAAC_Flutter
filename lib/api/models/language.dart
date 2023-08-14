import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive_built_value/hive_built_value.dart';

import '../serializers/serializers.dart';

part 'language.g.dart';

@HiveType(typeId: 0)
abstract class Language implements Built<Language, LanguageBuilder>  {

  factory Language([final void Function(LanguageBuilder) updates]) = _$Language;
  Language._();

  @HiveField(0)
  String get id;

  @HiveField(1)
  String get displayName;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Language.serializer, this) as Map<String, dynamic>;
  }

  static Language fromJson(final Map<String, dynamic> json) {
    return serializers.deserializeWith(Language.serializer, json)!;
  }

  static Serializer<Language> get serializer => _$languageSerializer;
}