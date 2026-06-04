import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';
import '../api/models/word_group.dart';
import '../services/word_group_service.dart';

typedef ResolvedGroup = (WordGroup, List<Word>);

class WordGroupViewModel {
  WordGroupViewModel(this._service);

  final WordGroupService _service;
  StreamSubscription<List<ResolvedGroup>>? _sub;

  final resolvedGroups = BehaviorSubject<List<ResolvedGroup>>.seeded([]);

  void init() {
    _sub = _service
        .watchAll()
        .asyncMap(
          (groups) => Future.wait(
            groups.map((g) async {
              final words = await _service.getWordsForGroup(g);
              return (g, words) as ResolvedGroup;
            }),
          ),
        )
        .listen(resolvedGroups.add, onError: resolvedGroups.addError);
  }

  Future<void> save(WordGroup group) => _service.save(group);

  Future<void> delete(String groupId) => _service.delete(groupId);

  void dispose() {
    _sub?.cancel();
    resolvedGroups.close();
  }
}
