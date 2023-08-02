import 'package:drift/drift.dart';

import '../databases/app_database.dart';
import '../models/word.dart';

part 'word_dao.g.dart';

@DriftAccessor(tables: [Word])
class WordDao extends DatabaseAccessor<AppDatabase> with _$WordDaoMixin {

  WordDao(this.db) : super(db);

  final AppDatabase db;

  Future<List<Word>> getAllTasks() => select(words).get();
  Stream<List<Word>> watchAllTasks() => select(words).watch();
  Future insertTask(final Word word) => into(words).insert(word);
  Future updateTask(final Word word) => update(words).replace(word);
  Future deleteTask(final Word word) => delete(words).delete(word);
}