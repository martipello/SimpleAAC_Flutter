import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:simple_aac/api/models/sentence.dart';
import 'package:simple_aac/api/models/word_group.dart';
import 'package:simple_aac/api/models/word_groups_response.dart';

import '../models/language.dart';
import '../models/languages_response.dart';
import '../models/sentences_response.dart';
import '../models/word.dart';
import '../models/word_base.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor(
  [
    Language,
    LanguagesResponse,
    Sentence,
    SentencesResponse,
    Word,
    WordGroup,
    WordGroupsResponse,
    WordSubType,
    WordType,
  ],
)
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
