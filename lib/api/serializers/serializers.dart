import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:simple_aac/api/models/sentence.dart';
import 'package:simple_aac/api/models/word_group.dart';

import '../models/language.dart';
import '../models/language_response.dart';
import '../models/word.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor(
  [
    Language,
    LanguageResponse,
    Sentence,
    Word,
    WordGroup,
    WordSubType,
    WordType,
  ],
)
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
