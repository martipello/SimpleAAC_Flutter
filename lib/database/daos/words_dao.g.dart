// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_dao.dart';

// ignore_for_file: type=lint
mixin _$WordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WordsTableTable get wordsTable => attachedDatabase.wordsTable;
  $WordOverridesTableTable get wordOverridesTable =>
      attachedDatabase.wordOverridesTable;
  WordsDaoManager get managers => WordsDaoManager(this);
}

class WordsDaoManager {
  final _$WordsDaoMixin _db;
  WordsDaoManager(this._db);
  $$WordsTableTableTableManager get wordsTable =>
      $$WordsTableTableTableManager(_db.attachedDatabase, _db.wordsTable);
  $$WordOverridesTableTableTableManager get wordOverridesTable =>
      $$WordOverridesTableTableTableManager(
        _db.attachedDatabase,
        _db.wordOverridesTable,
      );
}
