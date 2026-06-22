import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

import '../api/models/word_sub_type.dart';
import '../api/models/word_type.dart';
import 'daos/sync_dao.dart';
import 'daos/word_groups_dao.dart';
import 'daos/word_usage_dao.dart';
import 'daos/words_dao.dart';
import 'tables.dart';

export 'daos/sync_dao.dart';
export 'daos/word_groups_dao.dart';
export 'daos/word_usage_dao.dart';
export 'daos/words_dao.dart';
export 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    WordsTable,
    WordOverridesTable,
    WordGroupsTable,
    WordUsageTable,
    SyncMetadataTable,
  ],
  daos: [
    WordsDao,
    WordGroupsDao,
    WordUsageDao,
    SyncDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(
    name: 'simple_aac',
    web: kIsWeb
        ? DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          )
        : null,
  ));

  /// Only used in tests — accepts an in-memory executor.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
