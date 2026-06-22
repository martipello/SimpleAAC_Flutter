import 'package:flutter/material.dart';

import 'simple_aac_loading_widget.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.onPressed,
    this.isLoading = false,
    this.isFilled = true,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFilled;
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  static const _shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(18)),
  );

  @override
  Widget build(BuildContext context) {
    final child = isLoading ? _buildLoading() : _buildContent();
    if (isFilled) {
      return FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(shape: _shape),
        child: child,
      );
    }
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(shape: _shape),
      child: child,
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(leadingIcon, size: 18),
          ),
        Flexible(child: Text(label)),
        if (trailingIcon != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(trailingIcon, size: 18),
          ),
      ],
    );
  }

  Widget _buildLoading() {
    return const SizedBox(
      height: 16,
      width: 16,
      child: SimpleAACLoadingWidget(width: 2),
    );
  }
}
