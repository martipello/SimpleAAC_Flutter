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
          Container(
            color: context.themeColors.surfaceVariant,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title != null
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        child: Text(
                          title!,
                          style: SimpleAACText.subtitle1Style,
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: IconButton(
                    splashRadius: 12,
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: content,
          ),
          const SizedBox(
            height: 24,
          ),
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
    return TextButton(
      onPressed: action.actionVoidCallback,
      child: Text(
        action.actionText,
        style: SimpleAACText.body3Style,
        textAlign: TextAlign.end,
      ),
    );
  }
}

class DialogAction {
  DialogAction({
    required this.actionText,
    required this.actionVoidCallback,
  });

  final String actionText;
  final VoidCallback actionVoidCallback;
}
