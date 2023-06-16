import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import '../models/word.dart';
import '../models/word_response.dart';
import '../models/word_sub_type.dart';
import '../models/word_type.dart';
import 'date_time_serializer.dart';

part 'serializers.g.dart';

@SerializersFor(
  [
    Word,
    WordResponse,
    WordSubType,
    WordType,
  ],
)
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
