import 'word_sub_type.dart';
import 'word_type.dart';

mixin WordBase {
  String get id;

  double? get usageCount;

  WordType get type;

  WordSubType get subType;
}
