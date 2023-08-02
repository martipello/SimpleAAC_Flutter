import 'dart:io';

import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../daos/language_dao.dart';
import '../daos/sentence_dao.dart';
import '../daos/word_dao.dart';
import '../daos/word_group_dao.dart';
import '../models/language.dart';
import '../models/sentence.dart';
import '../models/word.dart';
import '../models/word_base.dart';
import '../models/word_group.dart';
import '../models/word_image_info.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Language, WordGroup, Sentence, Word, WordBase, WordImageInfo],
  daos: [LanguageDao, WordGroupDao, SentenceDao, WordDao, WordBaseDao, WordImageInfo]
)

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}