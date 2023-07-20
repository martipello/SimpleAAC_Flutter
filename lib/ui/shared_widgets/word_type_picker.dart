import 'package:flutter/material.dart';
import '../../api/models/extensions/word_type_extension.dart';

import '../../api/models/word_type.dart';
import '../theme/simple_aac_text.dart';

typedef WordTypePickerCallBack = void Function(WordType? wordType);
typedef WordTypePickerValidator = String Function(WordType? wordType);

class WordTypePicker extends StatelessWidget {
  const WordTypePicker({
    required this.wordTypePickerCallBack,
    this.wordTypePickerValidator,
    this.wordType,
  });

  final WordTypePickerCallBack wordTypePickerCallBack;
  final WordTypePickerValidator? wordTypePickerValidator;
  final WordType? wordType;

  @override
  Widget build(final BuildContext context) {
    return _buildReasonPicker(context);
  }

  Widget _buildReasonPicker(
    final BuildContext context,
  ) {
    return DropdownButtonFormField<WordType>(
      hint: Text(
        wordType?.name.toUpperCase() ?? 'Word Type',
        style: SimpleAACText.body3Style,
      ),
      isDense: true,
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: wordType.getColor(context),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: wordType.getColor(context),
            width: 2,
          ),
        ),
      ),
      isExpanded: true,
      validator: wordTypePickerValidator,
      items: _getDropdownMenuItems(),
      onChanged: wordTypePickerCallBack,
    );
  }

  List<DropdownMenuItem<WordType>> _getDropdownMenuItems() {
    return WordType.values
        .map(
          (final e) => DropdownMenuItem<WordType>(
            value: e,
            child: Text(
              e.name.toUpperCase(),
              style: SimpleAACText.body1Style,
            ),
          ),
        )
        .toList();
  }
}
