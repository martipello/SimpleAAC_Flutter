import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../api/models/word_type.dart';
import '../api/repositories/vocabulary_repository.dart';
import 'auth_service.dart';
import 'language_service.dart';

class WordService {
  WordService(this._vocabulary, this._auth, this._language);

  final VocabularyRepository _vocabulary;
  final AuthService _auth;
  final LanguageService _language;

  String get _uid => _auth.currentUserId ?? 'anonymous';
  String get _languageId => _language.currentLanguageId;

  Stream<List<Word>> watchSubType(WordSubType subType) =>
      _vocabulary.watchWordsForSubType(_uid, _languageId, subType);

  Stream<List<Word>> watchType(WordType type) =>
      _vocabulary.watchWordsForType(_uid, _languageId, type);

  Stream<List<Word>> watchFavourites() =>
      _vocabulary.watchFavourites(_uid, _languageId);

  Future<List<Word>> getWordsForIds(List<String> ids) async {
    final core = _vocabulary.getCoreWordsForIds(_languageId, ids);
    final found = core.map((w) => w.wordId).toSet();
    final missing = ids.where((id) => !found.contains(id)).toList();
    if (missing.isEmpty) return core;
    // Any missing IDs may be custom words — fetch from Firestore once
    final custom = await _vocabulary
        .watchCustomWords(_uid)
        .first
        .then((all) => all.where((w) => missing.contains(w.wordId)).toList());
    return [...core, ...custom];
  }

  Future<List<Word>> getRelatedWords(Word word) async {
    final ids = {
      ...word.extraRelatedWordIds,
      ...word.aiSuggestedFollowUps,
    }.toList();
    if (ids.isEmpty) return [];
    return getWordsForIds(ids);
  }

  Future<void> saveCustomWord(Word word) =>
      _vocabulary.saveCustomWord(_uid, word);

  Future<Word> toggleFavourite(Word word) async {
    final updated = word.copyWith(isFavourite: !word.isFavourite);
    await _vocabulary.saveCustomWord(_uid, updated);
    return updated;
  }

  Future<void> deleteCustomWord(String wordId) =>
      _vocabulary.deleteCustomWord(_uid, wordId);

  List<Word> searchWords(String query) {
    if (query.isEmpty) return [];
    return _vocabulary.searchWords(_languageId, query.toLowerCase());
  }

  List<Word> getAllCoreWords() => _vocabulary.getAllCoreWordsForLanguage(_languageId);
}
