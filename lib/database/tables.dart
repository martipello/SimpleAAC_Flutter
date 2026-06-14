import 'dart:convert';

import 'package:drift/drift.dart';

import '../api/models/word_sub_type.dart';
import '../api/models/word_type.dart';

// ── Type converters ───────────────────────────────────────────────────────────

class WordTypeConverter extends TypeConverter<WordType, String> {
  const WordTypeConverter();
  @override
  WordType fromSql(String s) => WordType.values.byName(s);
  @override
  String toSql(WordType v) => v.name;
}

class WordSubTypeConverter extends TypeConverter<WordSubType, String> {
  const WordSubTypeConverter();
  @override
  WordSubType fromSql(String s) => WordSubType.values.byName(s);
  @override
  String toSql(WordSubType v) => v.name;
}

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();
  @override
  List<String> fromSql(String s) => (jsonDecode(s) as List).cast<String>();
  @override
  String toSql(List<String> v) => jsonEncode(v);
}

// Nullable variant for optional List<double> columns.
class NullableDoubleListConverter extends TypeConverter<List<double>?, String?> {
  const NullableDoubleListConverter();
  @override
  List<double>? fromSql(String? s) => s == null
      ? null
      : (jsonDecode(s) as List).map((e) => (e as num).toDouble()).toList();
  @override
  String? toSql(List<double>? v) => v == null ? null : jsonEncode(v);
}

// ── Tables ────────────────────────────────────────────────────────────────────

/// Core vocabulary — admin-owned, never modified per-user.
/// Seeded from Firebase /vocabulary/{langId}/words on first launch / refresh.
@DataClassName('WordRow')
class WordsTable extends Table {
  @override
  String get tableName => 'words';

  TextColumn get wordId => text()();
  TextColumn get languageId => text()();
  // Named 'wordText' to avoid conflicting with Drift's text() builder method.
  // SQL column name: word_text
  TextColumn get wordText => text()();
  TextColumn get phoneticOverride => text().nullable()();
  // Non-nullable enum columns: withDefault/nullable not needed, map() last.
  TextColumn get type => text().map(const WordTypeConverter())();
  TextColumn get subType => text().map(const WordSubTypeConverter())();
  TextColumn get imagePath => text().nullable()();
  // withDefault must come before map() in the builder chain.
  TextColumn get extraRelatedWordIds =>
      text().withDefault(const Constant('[]')).map(const StringListConverter())();
  TextColumn get aiSuggestedFollowUps =>
      text().withDefault(const Constant('[]')).map(const StringListConverter())();
  // Nullable mapped column: use a nullable-aware TypeConverter.
  TextColumn get localEmbedding =>
      text().nullable().map(const NullableDoubleListConverter())();
  DateTimeColumn get createdDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {wordId};
}

/// Sparse per-user overrides — only the fields the user has actually changed.
/// A null field means "not overridden; use the core word value".
/// Enum fields (type, subType) are stored as plain nullable text to avoid
/// Drift generator issues with nullable TypeConverters; conversion is done
/// in the DAO.
/// Synced from Firebase /users/{uid}/wordOverrides.
@DataClassName('WordOverrideRow')
class WordOverridesTable extends Table {
  @override
  String get tableName => 'word_overrides';

  TextColumn get wordId => text()();
  BoolColumn get isFavourite => boolean().nullable()();
  // Named 'wordText' to avoid conflicting with Drift's text() builder method.
  // SQL column name: word_text
  TextColumn get wordText => text().nullable()();
  TextColumn get phoneticOverride => text().nullable()();
  // Stored as raw enum name strings; converted to WordType/WordSubType in DAO.
  TextColumn get type => text().nullable()();
  TextColumn get subType => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {wordId};
}

/// User-created phrase cards.
/// Synced from Firebase /users/{uid}/wordGroups.
@DataClassName('WordGroupRow')
class WordGroupsTable extends Table {
  @override
  String get tableName => 'word_groups';

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get wordIds =>
      text().withDefault(const Constant('[]')).map(const StringListConverter())();
  TextColumn get phoneticOverride => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  BoolColumn get isFavourite =>
      boolean().withDefault(const Constant(false))();
  IntColumn get usageCount =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get createdDate => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Per-word usage counts, incremented on every tap.
@DataClassName('WordUsageRow')
class WordUsageTable extends Table {
  @override
  String get tableName => 'word_usage';

  TextColumn get wordId => text()();
  IntColumn get count => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsed => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {wordId};
}

/// Tracks the last sync timestamp per Firebase collection.
/// collection key examples: 'vocabulary_en', 'word_overrides', 'word_groups'
@DataClassName('SyncMetadataRow')
class SyncMetadataTable extends Table {
  @override
  String get tableName => 'sync_metadata';

  TextColumn get collection => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {collection};
}
