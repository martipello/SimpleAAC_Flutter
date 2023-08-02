import 'package:drift/drift.dart';

import '../databases/app_database.dart';
import '../models/word.dart';
import '../models/word_group.dart';

part 'word_group_dao.g.dart';

@DriftAccessor(tables: [WordGroup])
class WordGroupDao extends DatabaseAccessor<AppDatabase> with _$WordGroupDaoMixin {

  WordGroupDao(this.db) : super(db);

  final AppDatabase db;

  Future<List<WordGroup>> getAllTasks() => select(wordGroups).get();
  Stream<List<WordGroup>> watchAllTasks() => select(wordGroups).watch();
  Future insertTask(final WordGroup wordGroup) => into(wordGroups).insert(wordGroup);
  Future updateTask(final WordGroup wordGroup) => update(wordGroups).replace(wordGroup);
  Future deleteTask(final WordGroup wordGroup) => delete(wordGroups).delete(wordGroup);
}