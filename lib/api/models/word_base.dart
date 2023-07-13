import 'package:simple_aac/api/models/word_sub_type.dart';
import 'package:simple_aac/api/models/word_type.dart';

mixin WordBase {
  String get id;

  double? get usageCount;

  WordType get type;

  WordSubType get subType;
}
