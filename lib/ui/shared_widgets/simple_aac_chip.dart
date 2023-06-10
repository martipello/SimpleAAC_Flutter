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
    return _buildChipWrapper(context);
  }

  Widget _buildChipWrapper(BuildContext context) {
    return SizedBox(
      height: 32,
      child: chipType == ChipType.filter
          ? _buildFilterChip()
          : _buildInputChip(
              context,
            ),
    );
  }

  Widget _buildInputChip(
    BuildContext context,
  ) {
    return InputChip(
      avatar: icon,
      label: Text(
        label,
        style: SimpleAACText.body4Style,
      ),
      padding: EdgeInsets.zero,
      labelStyle: SimpleAACText.body4Style,
      onPressed: onTap ?? () {},
      isEnabled: true,
      deleteButtonTooltipMessage: 'Remove',
      deleteIconColor: context.themeColors.onBackground,
      onDeleted: onDelete,
      deleteIcon: isRemovable
          ? const Icon(
              Icons.close,
            )
          : null,
    );
  }

  Widget _buildFilterChip() {
    return FilterChip(
      avatar: isSelected ? icon : null,
      label: Text(label.capitalize()),
      padding: EdgeInsets.zero,
      labelStyle: SimpleAACText.body4Style,
      onSelected: onSelected,
      selected: isSelected,
      showCheckmark: icon == null,
    );
  }
}
