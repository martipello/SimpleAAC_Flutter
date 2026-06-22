import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import '../../api/models/extensions/word_extension.dart';
import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../services/word_service.dart';
import '../../services/word_usage_service.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class CoreWordView extends StatefulWidget {
  const CoreWordView({super.key});

  @override
  State<CoreWordView> createState() => _CoreWordViewState();
}

class _CoreWordViewState extends State<CoreWordView>
    with AutomaticKeepAliveClientMixin {
  final _wordService = getIt.get<WordService>();
  final _usageService = getIt.get<WordUsageService>();
  final _selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  late final Stream<List<Word>> _words = CombineLatestStream.combine2(
    _wordService.watchFavourites(),
    _usageService
        .watchAll()
        .startWith([])
        .onErrorReturn([])
        .map((usages) => <String, int>{for (final u in usages) u.wordId: u.count}),
    (words, counts) => [...words]
      ..sort((a, b) => (counts[b.wordId] ?? 0).compareTo(counts[a.wordId] ?? 0)),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Word>>(
      stream: _words,
      builder: (context, snapshot) {
        final words = snapshot.data ?? [];
        if (words.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 64,
                  color: context.themeColors.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'No favourites yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: context.themeColors.onSurface.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Long-press a word and heart it\nto pin it here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.themeColors.onSurface.withOpacity(0.35),
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.86,
            children: words
                .map(
                  (word) => WordTile(
                    word: word,
                    key: ValueKey(word.wordId),
                    heroTag: word.getHeroTag('favourites-${word.wordId}'),
                    wordTapCallBack: _selectedWordsViewModel.addSelectedWord,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
