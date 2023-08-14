import 'package:built_collection/built_collection.dart';
import 'package:hive_built_value/hive_built_value.dart';

import 'word_sub_type.dart';
import 'word_type.dart';

mixin WordBase {

  @HiveField(0)
  String get id;

  @HiveField(1)
  WordType get type;

  @HiveField(2)
  WordSubType get subType;

  @HiveField(3)
  DateTime? get createdDate;

  @HiveField(4)
  double? get usageCount;

  @HiveField(5)
  bool? get isFavourite;

  @HiveField(6)
  bool? get isUserAdded;

  @HiveField(7)
  bool? get isBackedUp;

  @HiveField(8)
  BuiltList<String> get languageIds;
}
