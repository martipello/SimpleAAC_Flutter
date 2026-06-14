import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../api/models/word_type.dart';
import '../database/app_database.dart';
import 'language_service.dart';
import 'sync_mediator.dart';

class WordService {
  WordService(this._wordsDao, this._mediator, this._language);

  final WordsDao _wordsDao;
  final SyncMediator _mediator;
  final LanguageService _language;

  String get _languageId => _language.currentLanguageId;

  Stream<List<Word>> watchSubType(WordSubType subType) =>
      _wordsDao.watchWordsForSubType(_languageId, subType);

  Stream<List<Word>> watchType(WordType type) =>
      _wordsDao.watchWordsForType(_languageId, type);

  Stream<List<Word>> watchFavourites() =>
      _wordsDao.watchFavourites(_languageId);

  Future<List<Word>> getWordsForIds(List<String> ids) {
    if (ids.isEmpty) return Future.value([]);
    return _wordsDao.getByIds(_languageId, ids);
  }

  Future<List<Word>> getRelatedWords(Word word) {
    final ids = {...word.extraRelatedWordIds, ...word.aiSuggestedFollowUps}.toList();
    if (ids.isEmpty) return Future.value([]);
    return getWordsForIds(ids);
  }

  Future<void> saveCustomWord(Word word, {Word? original}) {
    if (word.isCoreVocabulary && original != null) {
      // Only send fields that actually changed relative to the original.
      return _mediator.applyWordOverride(
        word.wordId,
        wordText: word.text != original.text ? word.text : SyncMediator.absent,
        phoneticOverride: word.phoneticOverride != original.phoneticOverride
            ? word.phoneticOverride
            : SyncMediator.absent,
        type: word.type != original.type ? word.type.name : SyncMediator.absent,
        subType: word.subType != original.subType ? word.subType.name : SyncMediator.absent,
        imagePath: word.imagePath != original.imagePath ? word.imagePath : SyncMediator.absent,
      );
    }
    // Brand-new user-created word — full upsert.
    return _mediator.saveWord(word, _languageId);
  }

  Future<Word> toggleFavourite(Word word) async {
    final toggled = !word.isFavourite;
    await _mediator.setWordFavourite(word.wordId, isFavourite: toggled);
    return word.copyWith(isFavourite: toggled);
  }

  Future<void> deleteCustomWord(String wordId) =>
      _mediator.deleteWord(wordId);

  Future<List<Word>> searchWords(String query) {
    if (query.isEmpty) return Future.value([]);
    return _wordsDao.searchWords(_languageId, query);
  }

  Future<List<Word>> getAllWords() =>
      _wordsDao.watchAll(_languageId).first;
}
