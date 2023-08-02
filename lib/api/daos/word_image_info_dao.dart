import 'package:drift/drift.dart';

import '../databases/app_database.dart';
import '../models/word_image_info.dart';

part 'word_image_info_dao.g.dart';

@DriftAccessor(tables: [WordImageInfoImageInfo])
class WordImageInfoDao extends DatabaseAccessor<AppDatabase> with _$WordImageInfoDaoMixin {

  WordImageInfoDao(this.db) : super(db);

  final AppDatabase db;

  Future<List<WordImageInfo>> getAllTasks() => select(wordImageInfo).get();
  Stream<List<WordImageInfo>> watchAllTasks() => select(wordImageInfo).watch();
  Future insertTask(final WordImageInfo WordImageInfo) => into(wordImageInfo).insert(wordImageInfo);
  Future updateTask(final WordImageInfo WordImageInfo) => update(wordImageInfo).replace(wordImageInfo);
  Future deleteTask(final WordImageInfo WordImageInfo) => delete(wordImageInfo).delete(wordImageInfo);
}