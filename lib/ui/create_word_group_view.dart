import 'dart:ui';

import 'package:flutter/material.dart';

import '../api/models/word.dart';
import '../api/models/word_group.dart';
import '../api/models/word_type.dart';
import '../api/models/extensions/word_type_extension.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../extensions/string_extension.dart';
import '../services/word_group_service.dart';
import '../view_models/word_group_view_model.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/view_constraint.dart';
import 'shared_widgets/word_tile.dart';
import 'word_type_views/word_type_view.dart';

class CreateWordGroupViewArguments {
  const CreateWordGroupViewArguments({this.existingGroup});
  final WordGroup? existingGroup;
}

class CreateWordGroupView extends StatefulWidget {
  static const routeName = '/create-word-group';

  const CreateWordGroupView({super.key});

  @override
  State<CreateWordGroupView> createState() => _CreateWordGroupViewState();
}

const _pickerWordTypes = [
  WordType.things,
  WordType.actions,
  WordType.describe,
  WordType.social,
  WordType.grammar,
];

class _CreateWordGroupViewState extends State<CreateWordGroupView> {
  final _viewModel = getIt.get<WordGroupViewModel>();
  final _titleController = TextEditingController();
  final _scrollController = ScrollController();
  final List<Word> _selectedWords = [];
  int _selectedTypeIndex = 0;

  WordGroup? _existingGroup;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = context.routeArguments as CreateWordGroupViewArguments?;
    if (args?.existingGroup != null && _existingGroup == null) {
      _existingGroup = args!.existingGroup;
      _titleController.text = _existingGroup!.title;
      _loadExistingWords(_existingGroup!);
    }
  }

  Future<void> _loadExistingWords(WordGroup group) async {
    final words =
        await getIt.get<WordGroupService>().getWordsForGroup(group);
    if (mounted) {
      setState(() {
        _selectedWords.addAll(words);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _onWordTapped(Word word) {
    setState(() {
      final idx =
          _selectedWords.indexWhere((w) => w.wordId == word.wordId);
      if (idx >= 0) {
        _selectedWords.removeAt(idx);
      } else {
        _selectedWords.add(word);
      }
    });
    _scrollToEnd();
  }

  void _scrollToEnd() {
    const duration = Duration(milliseconds: 200);
    Future.delayed(duration).then((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: duration,
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  bool get _canSave =>
      _titleController.text.trim().isNotEmpty && _selectedWords.isNotEmpty;

  Future<void> _save() async {
    if (!_canSave) return;
    setState(() => _isLoading = true);
    final now = DateTime.now();
    final group = WordGroup(
      id: _existingGroup?.id ?? 'group_${now.millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      wordIds: _selectedWords.map((w) => w.wordId).toList(),
      createdDate: _existingGroup?.createdDate ?? now,
    );
    await _viewModel.save(group);
    if (mounted) Navigator.of(context).pop(group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(
        label: _existingGroup == null ? 'New Group' : 'Edit Group',
        actions: [
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _titleController,
            builder: (context, _, __) => TextButton(
              onPressed: _canSave && !_isLoading ? _save : null,
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitleField(),
          _buildSentenceBar(),
          const Divider(height: 1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WordTypeView(
                  key: ValueKey(_selectedTypeIndex),
                  wordType: _pickerWordTypes[_selectedTypeIndex],
                  wordTapCallBack: _onWordTapped,
                  selectedWordIds:
                      _selectedWords.map((w) => w.wordId).toSet(),
                ),
              ],
            ),
          ),
          _buildTypeSelector(),
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    return ViewConstraint(
      child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: _titleController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Group name…',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          isDense: true,
        ),
        onChanged: (_) => setState(() {}),
      ),
      ),
    );
  }

  Widget _buildSentenceBar() {
    if (_selectedWords.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'Tap words below to build your sentence',
            style: TextStyle(color: context.themeColors.onSurface.withOpacity(0.4)),
          ),
        ),
      );
    }
    return SizedBox(
      height: 160,
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        buildDefaultDragHandles: false,
        proxyDecorator: _proxyDecorator,
        scrollController: _scrollController,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        itemCount: _selectedWords.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final word = _selectedWords.removeAt(oldIndex);
            _selectedWords.insert(newIndex, word);
          });
        },
        itemBuilder: (context, index) {
          final word = _selectedWords[index];
          return WordTile(
            key: ValueKey('sentence-${word.wordId}'),
            word: word,
            closeButtonOnTap: (_) =>
                setState(() => _selectedWords.removeAt(index)),
            hasReOrderButton: true,
            reorderIndex: index,
          );
        },
      ),
    );
  }

  Widget _proxyDecorator(
      Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final elevation = lerpDouble(
          0,
          8,
          Curves.easeInOut.transform(animation.value),
        )!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.1),
          child: child,
        );
      },
      child: child,
    );
  }

  Widget _buildTypeSelector() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      currentIndex: _selectedTypeIndex,
      onTap: (i) => setState(() => _selectedTypeIndex = i),
      items: _pickerWordTypes
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.getIcon()),
              label: e.name.capitalize(),
            ),
          )
          .toList(),
    );
  }
}
