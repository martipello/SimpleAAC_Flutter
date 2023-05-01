import 'package:flutter/material.dart';

import '../../extensions/string_extension.dart';
import '../theme/base_theme.dart';
import '../theme/simple_aac_text.dart';

typedef OnSelected = void Function(bool selected);

enum ChipType { filter, normal }

class SimpleAACChip extends StatelessWidget {
  const SimpleAACChip({
    required this.chipType,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.onDelete,
    this.icon,
    this.onTap,
  });

  final String label;
  final ChipType chipType;
  final bool isSelected;
  final OnSelected? onSelected;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final Widget? icon;

  bool get isRemovable => onDelete != null;

  @override
  Widget build(BuildContext context) {
    if (chipType == ChipType.filter) {
      return SizedBox(
        height: 32,
        child: FilterChip(
          avatar: isSelected ? icon : null,
          label: Text(label.capitalize()),
          padding: EdgeInsets.zero,
          backgroundColor: colors(context).textOnForeground,
          labelStyle: SimpleAACText.body4Style.copyWith(
            color: colors(context).textOnForeground,
          ),
          onSelected: onSelected,
          selected: isSelected,
          showCheckmark: icon == null,
          selectedColor: colors(context).chromeLighter,
          checkmarkColor: colors(context).textOnForeground,
        ),
      );
    } else {
      return SizedBox(
        height: 32,
        child: InputChip(
          label: Text(label),
          padding: EdgeInsets.zero,
          backgroundColor: colors(context).foreground,
          labelStyle: SimpleAACText.body4Style.copyWith(
            color: colors(context).textOnForeground,
          ),
          onPressed: onTap,
          deleteButtonTooltipMessage: 'Remove',
          deleteIconColor: colors(context).textOnForeground,
          onDeleted: onDelete,
          deleteIcon: isRemovable ? const Icon(
            Icons.close,
          ) : null,
        ),
      );
    }
  }
}
