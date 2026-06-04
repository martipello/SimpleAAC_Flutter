import 'package:flutter/material.dart';

import '../../api/models/extensions/word_sub_type_extension.dart';
import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';

typedef WordSubTypePickerCallBack = void Function(WordSubType? wordSubType);

class WordSubTypePicker extends StatelessWidget {
  const WordSubTypePicker({
    required this.wordSubTypePickerCallBack,
    this.wordSubType,
    this.wordType,
  });

  final WordSubTypePickerCallBack wordSubTypePickerCallBack;
  final WordSubType? wordSubType;
  final WordType? wordType;

  List<WordSubType> get _subTypes => wordType?.getSubTypes() ?? [];

  WordSubType? get _resolvedSelection {
    if (wordSubType != null && _subTypes.contains(wordSubType)) return wordSubType;
    return _subTypes.isNotEmpty ? _subTypes.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<WordSubType>(
      key: ValueKey(wordType),
      initialSelection: _resolvedSelection,
      label: const Text('Category'),
      expandedInsets: EdgeInsets.zero,
      requestFocusOnTap: false,
      enableFilter: false,
      enableSearch: false,
      enabled: _subTypes.isNotEmpty,
      textStyle: Theme.of(context).textTheme.bodyMedium,
      onSelected: wordSubTypePickerCallBack,
      dropdownMenuEntries: _subTypes
          .map(
            (e) => DropdownMenuEntry<WordSubType>(
              value: e,
              label: e.name[0].toUpperCase() + e.name.substring(1),
              leadingIcon: Icon(e.getIcon(), size: 18),
            ),
          )
          .toList(),
    );
  }
}
