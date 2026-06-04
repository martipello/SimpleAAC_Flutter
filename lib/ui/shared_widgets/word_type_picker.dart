import 'package:flutter/material.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word_type.dart';

typedef WordTypePickerCallBack = void Function(WordType? wordType);

class WordTypePicker extends StatelessWidget {
  const WordTypePicker({
    required this.wordTypePickerCallBack,
    this.wordType,
  });

  final WordTypePickerCallBack wordTypePickerCallBack;
  final WordType? wordType;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<WordType>(
      key: ValueKey(wordType),
      initialSelection: wordType,
      label: const Text('Type'),
      expandedInsets: EdgeInsets.zero,
      requestFocusOnTap: false,
      enableFilter: false,
      enableSearch: false,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      onSelected: wordTypePickerCallBack,
      dropdownMenuEntries: WordType.values
          .map(
            (e) => DropdownMenuEntry<WordType>(
              value: e,
              label: e.name[0].toUpperCase() + e.name.substring(1),
              leadingIcon: Icon(e.getIcon(), size: 18),
            ),
          )
          .toList(),
    );
  }
}
