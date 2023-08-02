import 'package:drift/drift.dart';

class WordImageInfo extends Table {

  IntColumn get id => integer().autoIncrement().call();

  TextColumn get imageUri => text().call();

  IntColumn get keyStage => integer().nullable().call();

}