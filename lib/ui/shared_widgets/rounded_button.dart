import 'package:flutter/material.dart';

import '../theme/base_theme.dart';
import '../theme/simple_aac_text.dart';
import 'simple_aac_loading_widget.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.onPressed,
    this.fillColor,
    this.isLoading = false,
    this.isFilled = true,
    this.disableShadow = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.outlineColor,
    this.textStyle,
    this.elevation,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color? fillColor;
  final Color? outlineColor;
  final bool isLoading;
  final bool isFilled;
  final bool disableShadow;
  final double? elevation;
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            _getTextStyle(context),
          ),
          elevation: MaterialStateProperty.all(
            onPressed != null && !disableShadow ? elevation ?? 2 : 0,
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            _getFillColor(context),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: _getOutlineColor(context),
            ),
          ),
          overlayColor: MaterialStateProperty.all(Colors.black12),
        ),
        onPressed: _handleOnPressed(),
        child: Builder(
          builder: (context) {
            if (isLoading) return _buildLoading(context);
            return _buildButtonContent(context);
          },
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    var textStyle = _getTextStyle(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              leadingIcon,
              color: textStyle.color,
              size: textStyle.fontSize! + 2,
            ),
          ),
        Flexible(
          child: Text(
            label,
            style: textStyle,
          ),
        ),
        if (trailingIcon != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              trailingIcon,
              color: textStyle.color,
              size: textStyle.fontSize! + 2,
            ),
          ),
      ],
    );
  }

  Color _getFillColor(BuildContext context) {
    if (isFilled && onPressed != null) {
      return fillColor ?? colors(context).secondary;
    } else if (!isFilled && onPressed != null) {
      return colors(context).textOnSecondary;
    } else if (!isFilled && onPressed == null) {
      return colors(context).textOnSecondary;
    } else {
      return colors(context).foreground;
    }
  }

  Color _getOutlineColor(BuildContext context) {
    if (onPressed != null) {
      return outlineColor ?? fillColor ?? colors(context).secondary;
    } else {
      return colors(context).foreground;
    }
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (isFilled && onPressed != null) {
      return textStyle?.copyWith(color: colors(context).textOnSecondary) ??
          SimpleAACText.subtitle4Style.copyWith(color: colors(context).textOnSecondary);
    } else if (!isFilled && onPressed != null) {
      return SimpleAACText.subtitle4Style.copyWith(color: colors(context).secondary);
    } else if (isFilled && onPressed == null) {
      return SimpleAACText.subtitle4Style.copyWith(color: colors(context).textOnForeground);
    } else {
      return SimpleAACText.subtitle4Style.copyWith(color: colors(context).foreground);
    }
  }

  Color _getLoadingColor(BuildContext context) {
    if (isFilled && onPressed != null) {
      return colors(context).textOnSecondary;
    } else if (!isFilled && onPressed != null) {
      return colors(context).secondary;
    } else if (isFilled && onPressed == null) {
      return colors(context).textOnForeground;
    } else {
      return colors(context).foreground;
    }
  }

  Widget _buildLoading(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 16,
      child: SimpleAACLoadingWidget(
        width: 2,
        valueColor: _getLoadingColor(context),
      ),
    );
  }

  VoidCallback? _handleOnPressed() {
    if (!isLoading) {
      return onPressed;
    } else {
      return null;
    }
  }
}
