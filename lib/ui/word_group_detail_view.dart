import 'package:flutter/material.dart';

import '../api/models/word.dart';
import '../api/models/word_group.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../services/word_group_service.dart';
import '../view_models/word_group_view_model.dart';
import 'create_word_group_view.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/word_tile.dart';

class WordGroupDetailViewArguments {
  const WordGroupDetailViewArguments({required this.group});
  final WordGroup group;
}

class WordGroupDetailView extends StatefulWidget {
  static const routeName = '/word-group-detail';

  const WordGroupDetailView({super.key});

  @override
  State<WordGroupDetailView> createState() => _WordGroupDetailViewState();
}

class _WordGroupDetailViewState extends State<WordGroupDetailView> {
  late WordGroup _group;
  List<Word>? _words;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        context.routeArguments as WordGroupDetailViewArguments;
    if (_words == null) {
      _group = args.group;
      _loadWords();
    }
  }

  Future<void> _loadWords() async {
    final words = await getIt
        .get<WordGroupService>()
        .getWordsForGroup(_group);
    if (mounted) setState(() => _words = words);
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete group?'),
        content: Text('Remove "${_group.title}" permanently?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await getIt.get<WordGroupViewModel>().delete(_group.id);
      Navigator.of(context).pop();
    }
  }

  Future<void> _edit() async {
    final updated = await Navigator.of(context).pushNamed(
      CreateWordGroupView.routeName,
      arguments: CreateWordGroupViewArguments(existingGroup: _group),
    ) as WordGroup?;
    if (updated != null && mounted) {
      setState(() {
        _group = updated;
        _words = null;
      });
      _loadWords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(
        label: _group.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: _edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _delete,
          ),
        ],
      ),
      body: _words == null
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: play the group sentence via TTS
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _buildBody() {
    final words = _words!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildWordStrip(words),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Text(
            '${words.length} word${words.length == 1 ? '' : 's'}',
            style: TextStyle(
              color: context.themeColors.onSurface.withOpacity(0.55),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWordStrip(List<Word> words) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: words.length,
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (context, index) {
          final word = words[index];
          return WordTile(
            key: ValueKey(word.wordId),
            word: word,
          );
        },
      ),
    );
  }
}
