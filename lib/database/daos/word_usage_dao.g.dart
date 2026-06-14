// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_usage_dao.dart';

// ignore_for_file: type=lint
mixin _$WordUsageDaoMixin on DatabaseAccessor<AppDatabase> {
  $WordUsageTableTable get wordUsageTable => attachedDatabase.wordUsageTable;
  WordUsageDaoManager get managers => WordUsageDaoManager(this);
}

class WordUsageDaoManager {
  final _$WordUsageDaoMixin _db;
  WordUsageDaoManager(this._db);
  $$WordUsageTableTableTableManager get wordUsageTable =>
      $$WordUsageTableTableTableManager(
        _db.attachedDatabase,
        _db.wordUsageTable,
      );
}
