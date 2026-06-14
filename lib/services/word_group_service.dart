import '../api/models/word.dart';
import '../api/models/word_group.dart';
import '../database/app_database.dart';
import 'sync_mediator.dart';
import 'word_service.dart';

class WordGroupService {
  WordGroupService(this._wordGroupsDao, this._mediator, this._wordService);

  final WordGroupsDao _wordGroupsDao;
  final SyncMediator _mediator;
  final WordService _wordService;

  Stream<List<WordGroup>> watchAll() => _wordGroupsDao.watchAll();

  Future<void> save(WordGroup group) => _mediator.saveWordGroup(group);

  Future<void> delete(String groupId) => _mediator.deleteWordGroup(groupId);

  Future<List<Word>> getWordsForGroup(WordGroup group) =>
      _wordService.getWordsForIds(group.wordIds);
}
