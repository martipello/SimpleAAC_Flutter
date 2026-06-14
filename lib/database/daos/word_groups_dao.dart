import 'package:drift/drift.dart';

import '../../api/models/word_group.dart';
import '../app_database.dart';

part 'word_groups_dao.g.dart';

@DriftAccessor(tables: [WordGroupsTable])
class WordGroupsDao extends DatabaseAccessor<AppDatabase>
    with _$WordGroupsDaoMixin {
  WordGroupsDao(super.db);

  // ── Reads ─────────────────────────────────────────────────────────────────

  Stream<List<WordGroup>> watchAll() =>
      (select(wordGroupsTable)
            ..orderBy([(g) => OrderingTerm.desc(g.createdDate)]))
          .watch()
          .map((rows) => rows.map(_toModel).toList());

  // ── Writes ────────────────────────────────────────────────────────────────

  Future<void> upsert(WordGroup group) =>
      into(wordGroupsTable).insertOnConflictUpdate(_toCompanion(group));

  Future<void> deleteGroup(String id) =>
      (delete(wordGroupsTable)..where((g) => g.id.equals(id))).go();

  Future<void> incrementUsage(String id) => customStatement(
        'UPDATE word_groups '
        'SET usage_count = usage_count + 1, updated_at = ? '
        'WHERE id = ?',
        [DateTime.now().millisecondsSinceEpoch, id],
      );

  Future<void> upsertAll(List<WordGroup> groups) => batch(
        (b) => b.insertAllOnConflictUpdate(
          wordGroupsTable,
          groups.map(_toCompanion).toList(),
        ),
      );

  // ── Mapping ───────────────────────────────────────────────────────────────

  WordGroup _toModel(WordGroupRow row) => WordGroup(
        id: row.id,
        title: row.title,
        wordIds: row.wordIds,
        phoneticOverride: row.phoneticOverride,
        imagePath: row.imagePath,
        isFavourite: row.isFavourite,
        usageCount: row.usageCount,
        createdDate: row.createdDate,
      );

  WordGroupsTableCompanion _toCompanion(WordGroup g) => WordGroupsTableCompanion(
        id: Value(g.id),
        title: Value(g.title),
        wordIds: Value(g.wordIds),
        phoneticOverride: Value(g.phoneticOverride),
        imagePath: Value(g.imagePath),
        isFavourite: Value(g.isFavourite),
        usageCount: Value(g.usageCount),
        createdDate: Value(g.createdDate),
        updatedAt: Value(DateTime.now()),
      );
}
