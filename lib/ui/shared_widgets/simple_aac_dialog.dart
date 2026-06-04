import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../theme/simple_aac_text.dart';

extension SimpleAACDialogExtension on Widget {
  Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return this;
      },
    );
  }
}

class SimpleAACDialog extends StatelessWidget {
  const SimpleAACDialog({
    this.title,
    required this.content,
    this.dialogActions,
    this.dialogButtonBar,
    this.showOkButton = false,
  }) : assert(
          dialogActions != null || dialogButtonBar != null || showOkButton,
        );

  final String? title;
  final Widget content;
  final bool showOkButton;
  final List<DialogAction>? dialogActions;
  final Widget? dialogButtonBar;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Text(title!, style: SimpleAACText.subtitle1Style)
                else
                  const SizedBox(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: content,
          ),
          const SizedBox(height: 24),
          if (showOkButton)
            _buildPickerButtons(
              context,
              _getActions(
                context,
                [
                  DialogAction(
                    actionText: 'OK',
                    actionVoidCallback: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ),
          if (dialogButtonBar != null)
            dialogButtonBar!
          else
            _buildPickerButtons(
              context,
              _getActions(
                context,
                dialogActions,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPickerButtons(BuildContext context, List<Widget> actions) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
        child: Wrap(
          spacing: actions.length > 2 ? 0 : 16,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: WrapAlignment.end,
          direction: actions.length > 2 ? Axis.vertical : Axis.horizontal,
          verticalDirection: VerticalDirection.up,
          children: actions,
        ),
      ),
    );
  }

  List<Widget> _getActions(
    BuildContext context,
    List<DialogAction>? dialogActions,
  ) {
    return dialogActions
            ?.map(
              (action) => _buildDialogAction(
                action,
                context,
              ),
            )
            .toList() ??
        [];
  }

  Widget _buildDialogAction(
    DialogAction action,
    BuildContext context,
  ) {
    final color = action.color ?? context.themeColors.primary;
    return OutlinedButton(
      onPressed: action.actionVoidCallback,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
      ),
      child: Text(action.actionText, style: SimpleAACText.body3Style),
    );
  }
}

class DialogAction {
  DialogAction({
    required this.actionText,
    required this.actionVoidCallback,
    this.color,
  });

  final String actionText;
  final VoidCallback actionVoidCallback;
  final Color? color;
}
