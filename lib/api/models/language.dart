import 'package:drift/drift.dart';

part '../language.g.dart';

class Language extends Table {

  IntColumn get id => integer().autoIncrement().call();

  TextColumn get displayNme => text().call();

}