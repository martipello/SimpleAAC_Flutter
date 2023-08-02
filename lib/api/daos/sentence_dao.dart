import 'package:drift/drift.dart';

import '../databases/app_database.dart';
import '../models/sentence.dart';
import '../models/word.dart';
import '../models/word_group.dart';

part 'sentence_dao.g.dart';

@DriftAccessor(tables: [Sentence])
class SentenceDao extends DatabaseAccessor<AppDatabase> with _$SentenceDaoMixin {

  SentenceDao(this.db) : super(db);

  final AppDatabase db;

  Future<List<Sentence>> getAllTasks() => select(sentences).get();
  Stream<List<Sentence>> watchAllTasks() => select(sentences).watch();
  Future insertTask(final Sentence sentence) => into(sentences).insert(sentence);
  Future updateTask(final Sentence sentence) => update(sentences).replace(sentence);
  Future deleteTask(final Sentence sentence) => delete(sentences).delete(sentence);
}