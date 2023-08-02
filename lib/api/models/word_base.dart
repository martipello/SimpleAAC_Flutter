import 'package:drift/drift.dart';
import 'word_sub_type.dart';
import 'word_type.dart';

part '../word_base.g.dart';

class WordBase extends Table {

  IntColumn get id => integer().autoIncrement().call();

  IntColumn get usageCount => integer().nullable().call();

  TextColumn get type => textEnum<WordType>().call();

  TextColumn get subType => textEnum<WordSubType>().call();

  DateTimeColumn get dueDate => dateTime().nullable().call();

  BoolColumn get isBackedUp => boolean().withDefault(Constant(false)).call();

  BoolColumn get isFavorite => boolean().withDefault(Constant(false)).call();

  BoolColumn get isUserAdded => boolean().withDefault(Constant(false)).call();
}
