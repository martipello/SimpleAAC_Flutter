import 'package:flutter/material.dart';

import '../dependency_injection_container.dart';
import '../view_models/word_group_view_model.dart';
import 'create_word_group_view.dart';
import 'shared_widgets/adaptive_position_floating_action_button.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/view_constraint.dart';
import 'shared_widgets/word_group_tile.dart';
import 'word_group_detail_view.dart';

class WordGroupsView extends StatefulWidget {
  static const String routeName = '/word-groups';

  const WordGroupsView({super.key});

  @override
  State<WordGroupsView> createState() => _WordGroupsViewState();
}

class _WordGroupsViewState extends State<WordGroupsView> {
  final _viewModel = getIt.get<WordGroupViewModel>();

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
    return Scaffold(
      appBar: SimpleAACAppBar(label: 'Groups'),
      body: ViewConstraint(
        child: StreamBuilder(
          stream: _viewModel.resolvedGroups,
          builder: (context, snapshot) {
            final groups = snapshot.data ?? [];
            if (groups.isEmpty) {
              return _buildEmptyState();
            }
            return _buildGrid(groups);
          },
        ),
      ),
      floatingActionButton: AdaptivePositionFloatingActionButton(
        onPressed: _createGroup,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.grid_view_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No groups yet',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Tap + to build and save a sentence.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List resolvedGroups) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / 200).floor().clamp(2, 6);
        return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1 / 1.3,
      ),
      itemCount: resolvedGroups.length,
      itemBuilder: (context, index) {
        final (group, words) = resolvedGroups[index];
        return WordGroupTile(
          key: ValueKey(group.id),
          group: group,
          words: words,
          onTap: () => Navigator.of(context).pushNamed(
            WordGroupDetailView.routeName,
            arguments: WordGroupDetailViewArguments(group: group),
          ),
        );
      },
        );
      },
    );
  }

  Future<void> _createGroup() async {
    await Navigator.of(context).pushNamed(
      CreateWordGroupView.routeName,
      arguments: const CreateWordGroupViewArguments(),
    );
  }
}
