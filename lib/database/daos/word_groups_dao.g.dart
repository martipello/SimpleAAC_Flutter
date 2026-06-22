// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_groups_dao.dart';

// ignore_for_file: type=lint
mixin _$WordGroupsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WordGroupsTableTable get wordGroupsTable => attachedDatabase.wordGroupsTable;
  WordGroupsDaoManager get managers => WordGroupsDaoManager(this);
}

class WordGroupsDaoManager {
  final _$WordGroupsDaoMixin _db;
  WordGroupsDaoManager(this._db);
  $$WordGroupsTableTableTableManager get wordGroupsTable =>
      $$WordGroupsTableTableTableManager(
        _db.attachedDatabase,
        _db.wordGroupsTable,
      );
}
