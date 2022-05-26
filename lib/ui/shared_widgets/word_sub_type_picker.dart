import 'package:flutter/material.dart';

import '../../api/models/extensions/word_sub_type_extension.dart';
import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../theme/base_theme.dart';
import '../theme/simple_aac_text.dart';

typedef WordSubTypePickerCallBack = void Function(WordSubType? wordSubType);
typedef WordSubTypePickerValidator = String Function(WordSubType? wordSubType);

class WordSubTypePicker extends StatelessWidget {
  const WordSubTypePicker({
    required this.wordSubTypePickerCallBack,
    this.wordSubTypePickerValidator,
    this.wordSubType,
    this.wordType,
  });

  final WordSubTypePickerCallBack wordSubTypePickerCallBack;
  final WordSubTypePickerValidator? wordSubTypePickerValidator;
  final WordSubType? wordSubType;
  final WordType? wordType;

  @override
  Widget build(BuildContext context) {
    return _buildReasonPicker(context);
  }

  Widget _buildReasonPicker(
    BuildContext context,
  ) {
    return DropdownButtonFormField<WordSubType>(
      hint: Text(
        wordSubType?.name.toUpperCase() ?? 'WordSub Type',
        style: SimpleAACText.body3Style,
      ),
      isDense: true,
      isExpanded: true,
      decoration: InputDecoration(
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: wordType?.getSubTypes().first.getColor(context) ?? colors(context).primary,
            width: 2.0,
          ),
        ),
      ),
      value: wordType?.getSubTypes().first,
      validator: wordSubTypePickerValidator,
      items: _getDropdownMenuItems(),
      onChanged: wordSubTypePickerCallBack,
    );
  }

  List<DropdownMenuItem<WordSubType>> _getDropdownMenuItems() {
    return wordType?.getSubTypes()
        .map(
          (e) => DropdownMenuItem<WordSubType>(
            value: e,
            child: Text(
              e.name.toUpperCase(),
              style: SimpleAACText.body4Style,
            ),
          ),
        )
        .toList() ?? [];
  }
}
