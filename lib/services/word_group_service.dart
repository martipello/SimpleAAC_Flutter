import '../api/models/word.dart';
import '../api/models/word_group.dart';
import '../api/repositories/word_group_repository.dart';
import 'auth_service.dart';
import 'word_service.dart';

class WordGroupService {
  WordGroupService(this._repository, this._auth, this._wordService);

  final WordGroupRepository _repository;
  final AuthService _auth;
  final WordService _wordService;

  String get _uid => _auth.currentUserId ?? 'anonymous';

  Stream<List<WordGroup>> watchAll() => _repository.watchAll(_uid);

  Future<void> save(WordGroup group) => _repository.save(_uid, group);

  Future<void> delete(String groupId) => _repository.delete(_uid, groupId);

  Future<List<Word>> getWordsForGroup(WordGroup group) =>
      _wordService.getWordsForIds(group.wordIds);
}
