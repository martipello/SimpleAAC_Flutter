import 'package:drift/drift.dart';

import '../../api/models/word_usage.dart';
import '../app_database.dart';

part 'word_usage_dao.g.dart';

@DriftAccessor(tables: [WordUsageTable])
class WordUsageDao extends DatabaseAccessor<AppDatabase>
    with _$WordUsageDaoMixin {
  WordUsageDao(super.db);

  // ── Reads ─────────────────────────────────────────────────────────────────

  Stream<List<WordUsage>> watchTopWords({int limit = 20}) =>
      (select(wordUsageTable)
            ..orderBy([(u) => OrderingTerm.desc(u.count)])
            ..limit(limit))
          .watch()
          .map((rows) => rows.map(_toModel).toList());

  Stream<List<WordUsage>> watchAll() => select(wordUsageTable)
      .watch()
      .map((rows) => rows.map(_toModel).toList());

  // ── Writes ────────────────────────────────────────────────────────────────

  /// Atomic increment — safe to call without reading first.
  Future<void> increment(String wordId) => customStatement(
        'INSERT INTO word_usage (word_id, count, last_used) VALUES (?, 1, ?) '
        'ON CONFLICT(word_id) DO UPDATE SET '
        'count = count + 1, last_used = excluded.last_used',
        [wordId, DateTime.now().millisecondsSinceEpoch],
      );

  Future<void> upsertAll(List<WordUsage> records) => batch(
        (b) => b.insertAllOnConflictUpdate(
          wordUsageTable,
          records.map(_toCompanion).toList(),
        ),
      );

  // ── Mapping ───────────────────────────────────────────────────────────────

  WordUsage _toModel(WordUsageRow row) => WordUsage(
        wordId: row.wordId,
        count: row.count,
        lastUsed: row.lastUsed,
      );

  WordUsageTableCompanion _toCompanion(WordUsage u) => WordUsageTableCompanion(
        wordId: Value(u.wordId),
        count: Value(u.count),
        lastUsed: Value(u.lastUsed),
      );
}
