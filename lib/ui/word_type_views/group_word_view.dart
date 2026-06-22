import 'package:flutter/material.dart';

import '../../dependency_injection_container.dart';
import '../../view_models/selected_words_view_model.dart';
import '../../view_models/word_group_view_model.dart';
import '../shared_widgets/word_group_tile.dart';
import '../word_group_detail_view.dart';

class GroupWordView extends StatefulWidget {
  const GroupWordView({super.key});

  @override
  State<GroupWordView> createState() => _GroupWordViewState();
}

class _GroupWordViewState extends State<GroupWordView>
    with AutomaticKeepAliveClientMixin {
  final _viewModel = getIt.get<WordGroupViewModel>();
  final _selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: _viewModel.resolvedGroups,
      builder: (context, snapshot) {
        final groups = snapshot.data ?? [];
        if (groups.isEmpty) {
          return _buildEmptyState();
        }
        return Padding(
          padding: const EdgeInsets.all(4),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1 / 1.3,
            ),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final (group, words) = groups[index];
              return WordGroupTile(
                key: ValueKey(group.id),
                group: group,
                words: words,
                onTap: () => _selectedWordsViewModel.addAllWords(words),
                onLongPress: () => Navigator.of(context).pushNamed(
                  WordGroupDetailView.routeName,
                  arguments: WordGroupDetailViewArguments(group: group),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.playlist_play_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No groups yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Use + to build and save a sentence group.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
