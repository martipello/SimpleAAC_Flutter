import 'dart:convert';

import 'package:drift/drift.dart';

import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../app_database.dart';

part 'words_dao.g.dart';

@DriftAccessor(tables: [WordsTable, WordOverridesTable])
class WordsDao extends DatabaseAccessor<AppDatabase> with _$WordsDaoMixin {
  WordsDao(super.db);

  // ── Writes ────────────────────────────────────────────────────────────────

  Future<void> upsertCoreWords(List<WordsTableCompanion> rows) =>
      batch((b) => b.insertAllOnConflictUpdate(wordsTable, rows));

  Future<void> upsertOverride(WordOverridesTableCompanion row) =>
      into(wordOverridesTable).insertOnConflictUpdate(row);

  Future<void> deleteOverride(String wordId) =>
      (delete(wordOverridesTable)
            ..where((o) => o.wordId.equals(wordId)))
          .go();

  Future<void> deleteWord(String wordId) =>
      (delete(wordsTable)..where((w) => w.wordId.equals(wordId))).go();

  Future<void> clearCoreWords(String languageId) =>
      (delete(wordsTable)
            ..where((w) => w.languageId.equals(languageId)))
          .go();

  // ── Reads (merged core + override) ────────────────────────────────────────

  Stream<List<Word>> watchWordsForSubType(
    String languageId,
    WordSubType subType,
  ) =>
      _mergedQuery(languageId, subType: subType).watch().map(_toWords);

  Stream<List<Word>> watchWordsForType(
    String languageId,
    WordType type,
  ) =>
      _mergedQuery(languageId, type: type).watch().map(_toWords);

  Stream<List<Word>> watchFavourites(String languageId) =>
      _mergedQuery(languageId, favouritesOnly: true).watch().map(_toWords);

  Stream<List<Word>> watchAll(String languageId) =>
      _mergedQuery(languageId).watch().map(_toWords);

  Future<List<Word>> searchWords(String languageId, String query) =>
      _mergedQuery(languageId, search: query).get().then(_toWords);

  Future<List<Word>> getByIds(String languageId, List<String> ids) =>
      _mergedQuery(languageId, ids: ids).get().then(_toWords);

  // ── Merge query ───────────────────────────────────────────────────────────
  //
  // The SQL LEFT JOIN merges core words with the user's sparse overrides.
  // COALESCE picks the override value when present, otherwise falls back to
  // the core value. isFavourite defaults to 0 (false) since core words
  // never carry that flag.

  static const _select = '''
    SELECT
      w.word_id,
      w.language_id,
      COALESCE(o.word_text,         w.word_text)         AS word_text,
      COALESCE(o.phonetic_override, w.phonetic_override) AS phonetic_override,
      COALESCE(o.type,              w.type)              AS type,
      COALESCE(o.sub_type,          w.sub_type)          AS sub_type,
      COALESCE(o.image_path,        w.image_path)        AS image_path,
      COALESCE(o.is_favourite,      0)                   AS is_favourite,
      w.extra_related_word_ids,
      w.ai_suggested_follow_ups,
      w.local_embedding,
      w.created_date
    FROM words w
    LEFT JOIN word_overrides o ON w.word_id = o.word_id
  ''';

  Selectable<QueryRow> _mergedQuery(
    String languageId, {
    WordSubType? subType,
    WordType? type,
    bool favouritesOnly = false,
    String? search,
    List<String>? ids,
  }) {
    final clauses = <String>['w.language_id = ?'];
    final vars = <Variable>[Variable.withString(languageId)];

    if (subType != null) {
      clauses.add('w.sub_type = ?');
      vars.add(Variable.withString(subType.name));
    }
    if (type != null) {
      clauses.add('w.type = ?');
      vars.add(Variable.withString(type.name));
    }
    if (favouritesOnly) {
      clauses.add('COALESCE(o.is_favourite, 0) = 1');
    }
    if (search != null && search.isNotEmpty) {
      clauses.add('LOWER(w.word_text) LIKE ?');
      vars.add(Variable.withString('%${search.toLowerCase()}%'));
    }
    if (ids != null && ids.isNotEmpty) {
      final placeholders = List.filled(ids.length, '?').join(', ');
      clauses.add('w.word_id IN ($placeholders)');
      vars.addAll(ids.map(Variable.withString));
    }

    final where = clauses.join(' AND ');
    return customSelect(
      '$_select WHERE $where',
      variables: vars,
      readsFrom: {wordsTable, wordOverridesTable},
    );
  }

  // ── Mapping ───────────────────────────────────────────────────────────────

  List<Word> _toWords(List<QueryRow> rows) => rows.map(_rowToWord).toList();

  Word _rowToWord(QueryRow r) {
    final extraRaw = r.readNullable<String>('extra_related_word_ids');
    final aiRaw = r.readNullable<String>('ai_suggested_follow_ups');
    final embeddingRaw = r.readNullable<String>('local_embedding');
    final createdMs = r.readNullable<int>('created_date');

    return Word(
      wordId: r.read<String>('word_id'),
      text: r.read<String>('word_text'),
      phoneticOverride: r.readNullable<String>('phonetic_override'),
      type: WordType.values.byName(r.read<String>('type')),
      subType: WordSubType.values.byName(r.read<String>('sub_type')),
      imagePath: r.readNullable<String>('image_path'),
      isFavourite: r.read<int>('is_favourite') == 1,
      extraRelatedWordIds: extraRaw != null
          ? (jsonDecode(extraRaw) as List).cast<String>()
          : [],
      aiSuggestedFollowUps: aiRaw != null
          ? (jsonDecode(aiRaw) as List).cast<String>()
          : [],
      localEmbedding: embeddingRaw != null
          ? (jsonDecode(embeddingRaw) as List)
              .map((e) => (e as num).toDouble())
              .toList()
          : null,
      createdDate: createdMs != null
          ? DateTime.fromMillisecondsSinceEpoch(createdMs)
          : null,
    );
  }

  // ── Companion helpers ─────────────────────────────────────────────────────

  static WordsTableCompanion coreWordToCompanion(
    Word word,
    String languageId,
  ) =>
      WordsTableCompanion(
        wordId: Value(word.wordId),
        languageId: Value(languageId),
        wordText: Value(word.text),
        phoneticOverride: Value(word.phoneticOverride),
        type: Value(word.type),
        subType: Value(word.subType),
        imagePath: Value(word.imagePath),
        extraRelatedWordIds: Value(word.extraRelatedWordIds),
        aiSuggestedFollowUps: Value(word.aiSuggestedFollowUps),
        localEmbedding: Value(word.localEmbedding),
        createdDate: Value(word.createdDate),
      );

  /// Builds an override companion from only the fields that differ from the
  /// core word. Callers pass non-null values only for fields they want to
  /// persist; everything else stays absent (null = not overridden).
  static WordOverridesTableCompanion overrideCompanion({
    required String wordId,
    bool? isFavourite,
    String? text,
    String? phoneticOverride,
    WordType? type,
    WordSubType? subType,
    String? imagePath,
  }) =>
      WordOverridesTableCompanion(
        wordId: Value(wordId),
        isFavourite: isFavourite != null ? Value(isFavourite) : const Value.absent(),
        wordText: text != null ? Value(text) : const Value.absent(),
        phoneticOverride:
            phoneticOverride != null ? Value(phoneticOverride) : const Value.absent(),
        // type/subType stored as raw enum name strings in the DB.
        type: type != null ? Value(type.name) : const Value.absent(),
        subType: subType != null ? Value(subType.name) : const Value.absent(),
        imagePath: imagePath != null ? Value(imagePath) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      );
}
