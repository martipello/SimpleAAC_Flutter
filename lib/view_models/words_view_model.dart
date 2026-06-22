import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';
import '../api/models/word_sub_type.dart';
import '../services/word_service.dart';
import '../services/word_usage_service.dart';

class WordsViewModel {
  WordsViewModel(this.wordService, this._usageService);

  final WordService wordService;
  final WordUsageService _usageService;

  StreamSubscription<List<Word>>? _subscription;

  final wordsOfType = BehaviorSubject<List<Word>>.seeded([]);

  /// Words sorted by usage count descending, updating live.
  /// Falls back to original order if usage data is unavailable (e.g. unauthenticated).
  late final Stream<List<Word>> sortedWordsOfType = CombineLatestStream.combine2(
    wordsOfType,
    _usageService
        .watchAll()
        .startWith([])
        .onErrorReturn([])
        .map((usages) => <String, int>{for (final u in usages) u.wordId: u.count}),
    (words, counts) => [...words]
      ..sort((a, b) => (counts[b.wordId] ?? 0).compareTo(counts[a.wordId] ?? 0)),
  );

  void init(WordSubType wordSubType) {
    _subscription = wordService.watchSubType(wordSubType).listen(
          wordsOfType.add,
          onError: wordsOfType.addError,
        );
  }

  void reinit(WordSubType wordSubType) {
    _subscription?.cancel();
    init(wordSubType);
  }

  Future<List<Word>> getWordsForIds(List<String> wordIds) async {
    return wordService.getWordsForIds(wordIds);
  }

  Future<Word> toggleFavourite(Word word) => wordService.toggleFavourite(word);

  void dispose() {
    _subscription?.cancel();
    wordsOfType.close();
  }
}
