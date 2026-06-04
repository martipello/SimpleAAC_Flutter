import '../api/models/word_usage.dart';
import '../api/repositories/word_usage_repository.dart';
import 'auth_service.dart';

class WordUsageService {
  WordUsageService(this._repository, this._auth);

  final WordUsageRepository _repository;
  final AuthService _auth;

  String get _uid => _auth.currentUserId ?? 'anonymous';

  /// Call whenever a word tile is tapped. Atomic, works offline.
  Future<void> increment(String wordId) => _repository.increment(_uid, wordId);

  /// Stream of the user's most-used words for AI predictions.
  Stream<List<WordUsage>> watchTopWords({int limit = 20}) =>
      _repository.watchTopWords(_uid, limit: limit);

  Stream<List<WordUsage>> watchAll() => _repository.watchAll(_uid);
}
