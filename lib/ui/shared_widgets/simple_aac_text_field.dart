import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';
import 'simple_aac_loading_widget.dart';

typedef Validator = String? Function(dynamic value);

class SimpleAACTextField extends StatelessWidget {
  const SimpleAACTextField({
    Key? key,
    required this.textController,
    required this.labelText,
    this.prefixIcon,
    this.validatorMessage,
    this.maxLines = 1,
    this.validator,
    this.textInputType,
    this.textInputAction,
    this.loading = false,
    this.isDense = true,
    this.isEnabled = true,
    this.textStyle,
  }) : super(key: key);

  final TextEditingController textController;
  final TextStyle? textStyle;
  final Validator? validator;
  final String labelText;
  final String? validatorMessage;
  final IconData? prefixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final bool loading;
  final bool isEnabled;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      style: textStyle ?? SimpleAACText.body1Style,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      decoration: _buildInputDecoration(context),
      onEditingComplete: textInputAction == TextInputAction.next ? () => context.nextEditableTextFocus() : null,
      validator: validator != null
          ? validator
          : validatorMessage != null
              ? _defaultValidator
              : null,
    );
  }

  String? _defaultValidator(value) {
    if (value == null || value.isEmpty) {
      return validatorMessage;
    }
    return null;
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: SimpleAACText.body1Style,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabled: isEnabled,
      isDense: isDense,
      errorMaxLines: 2,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 20,
        maxWidth: 42,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
            )
          : null,
      suffixIcon: loading
          ? const Center(
              child: SizedBox(
                height: 18,
                width: 18,
                child: SimpleAACLoadingWidget.circularProgressIndicator(
                  width: 2,
                ),
              ),
            )
          : textController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    textController.clear();
                  },
                )
              : null,
    );
  }
}
