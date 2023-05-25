import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../../extensions/string_extension.dart';
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
          backgroundColor: context.themeColors.background,
          labelStyle: SimpleAACText.body4Style.copyWith(
            color: context.themeColors.onBackground,
          ),
          onSelected: onSelected,
          selected: isSelected,
          showCheckmark: icon == null,
          selectedColor: context.themeColors.onInverseSurface,
          checkmarkColor: context.themeColors.onBackground,
        ),
      );
    } else {
      return SizedBox(
        height: 32,
        child: InputChip(
          avatar: icon,
          label: Text(
            label,
            style: SimpleAACText.body4Style.copyWith(
              color: context.themeColors.onBackground,
            ),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: context.themeColors.background,
          disabledColor: context.themeColors.onBackground,
          labelStyle: SimpleAACText.body4Style.copyWith(
            color: context.themeColors.onBackground,
          ),
          onPressed: onTap ?? (){},
          isEnabled: true,
          deleteButtonTooltipMessage: 'Remove',
          deleteIconColor: context.themeColors.onBackground,
          onDeleted: onDelete,
          deleteIcon: isRemovable
              ? const Icon(
                  Icons.close,
                )
              : null,
        ),
      );
    }
  }
}
