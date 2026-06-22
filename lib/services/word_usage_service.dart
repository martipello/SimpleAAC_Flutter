import '../api/models/word_usage.dart';
import '../database/app_database.dart';
import 'sync_mediator.dart';

class WordUsageService {
  WordUsageService(this._wordUsageDao, this._mediator);

  final WordUsageDao _wordUsageDao;
  final SyncMediator _mediator;

  /// Call whenever a word tile is tapped. Atomic, works offline.
  Future<void> increment(String wordId) => _mediator.incrementWordUsage(wordId);

  /// Stream of the user's most-used words for AI predictions.
  Stream<List<WordUsage>> watchTopWords({int limit = 20}) =>
      _wordUsageDao.watchTopWords(limit: limit);

  Stream<List<WordUsage>> watchAll() => _wordUsageDao.watchAll();
}
