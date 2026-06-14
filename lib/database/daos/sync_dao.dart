import 'package:drift/drift.dart';

import '../app_database.dart';

part 'sync_dao.g.dart';

/// Well-known collection keys — match Firebase path segments.
class SyncCollection {
  SyncCollection._();

  static String vocabulary(String languageId) => 'vocabulary_$languageId';
  static const wordOverrides = 'word_overrides';
  static const wordGroups = 'word_groups';
  static const wordUsage = 'word_usage';
}

@DriftAccessor(tables: [SyncMetadataTable])
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  Future<DateTime?> getLastSyncedAt(String collection) async {
    final row = await (select(syncMetadataTable)
          ..where((s) => s.collection.equals(collection)))
        .getSingleOrNull();
    return row?.lastSyncedAt;
  }

  Future<void> markSynced(String collection) =>
      into(syncMetadataTable).insertOnConflictUpdate(
        SyncMetadataTableCompanion(
          collection: Value(collection),
          lastSyncedAt: Value(DateTime.now()),
        ),
      );

  Future<void> clearSyncedAt(String collection) =>
      (delete(syncMetadataTable)
            ..where((s) => s.collection.equals(collection)))
          .go();
}
