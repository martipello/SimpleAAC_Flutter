import 'package:flutter/material.dart';

import '../api/models/word.dart';
import '../api/models/word_type.dart';
import '../api/models/extensions/word_type_extension.dart';
import '../extensions/string_extension.dart';
import 'shared_widgets/word_tile.dart';
import 'word_type_views/word_type_view.dart';

class WordPickerView extends StatefulWidget {
  const WordPickerView({super.key, this.existingWordIds = const []});

  final List<String> existingWordIds;

  static Future<List<String>?> show(BuildContext context, {List<String> existingWordIds = const []}) {
    return Navigator.of(context).push<List<String>>(
      MaterialPageRoute(
        builder: (_) => WordPickerView(existingWordIds: existingWordIds),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  State<WordPickerView> createState() => _WordPickerViewState();
}

const _pickerWordTypes = [
  WordType.things,
  WordType.actions,
  WordType.describe,
  WordType.social,
  WordType.grammar,
];

class _WordPickerViewState extends State<WordPickerView> {
  int _selectedIndex = 0;
  late final Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = Set.of(widget.existingWordIds);
  }

  void _onWordTapped(Word word) {
    setState(() {
      if (_selectedIds.contains(word.wordId)) {
        _selectedIds.remove(word.wordId);
      } else {
        _selectedIds.add(word.wordId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final addedCount = _selectedIds.length - widget.existingWordIds.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Predictions'),
        actions: [
          if (_selectedIds.isNotEmpty)
            TextButton(
              onPressed: () => Navigator.of(context).pop(_selectedIds.toList()),
              child: Text(
                addedCount > 0 ? 'Done ($addedCount)' : 'Done',
              ),
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: WordTypeView(
              wordType: _pickerWordTypes[_selectedIndex],
              wordTapCallBack: _onWordTapped,
              selectedWordIds: _selectedIds,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: _pickerWordTypes
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.getIcon()),
                label: e.name.capitalize(),
              ),
            )
            .toList(),
      ),
    );
  }
}
