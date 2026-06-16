import 'package:flutter/material.dart';

import '../../api/models/word.dart';
import '../../services/word_service.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class WordSearchDelegate extends SearchDelegate<Word?> {
  WordSearchDelegate(this._wordService, this._selectedWordsViewModel);

  final WordService _wordService;
  final SelectedWordsViewModel _selectedWordsViewModel;

  @override
  String get searchFieldLabel => 'Search words…';

  @override
  List<Widget> buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => query = '',
          ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildGrid(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildGrid(context);

  int _crossAxisCount(double width) {
    if (width > 1200) return 8;
    if (width > 800) return 6;
    return 4;
  }

  Widget _buildGrid(BuildContext context) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const Center(
        child: Icon(Icons.search, size: 64, color: Colors.grey),
      );
    }

    return FutureBuilder<List<Word>>(
      future: _wordService.searchWords(trimmed),
      builder: (context, snapshot) {
        final words = snapshot.data ?? [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (words.isEmpty) {
          return Center(
            child: Text(
              'No results for "$trimmed"',
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(4),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(MediaQuery.of(context).size.width),
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.86,
            ),
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return WordTile(
                key: ValueKey(word.wordId),
                word: word,
                wordTapCallBack: (w) {
                  _selectedWordsViewModel.addSelectedWord(w);
                  close(context, w);
                },
              );
            },
          ),
        );
      },
    );
  }
}
