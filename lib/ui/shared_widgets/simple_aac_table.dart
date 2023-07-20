import 'package:flutter/material.dart';

import '../theme/simple_aac_text.dart';

class SimpleAACTableRowInfo {
  SimpleAACTableRowInfo(
    this.label,
    this.iconData,
    this.iconLabel, {
    this.labelTextAlign,
    this.child,
    this.borderColor,
  });

  final String label;
  final String? iconLabel;
  final IconData iconData;
  final Widget? child;
  final Color? borderColor;
  final TextAlign? labelTextAlign;
}

class SimpleAACTable extends StatelessWidget {
  const SimpleAACTable({
    required this.wordskiiTableRowInfoList,
    this.tableTitle,
    this.tableTitleTextStyle,
  });

  final String? tableTitle;
  final TextStyle? tableTitleTextStyle;
  final List<SimpleAACTableRowInfo> wordskiiTableRowInfoList;

  @override
  Widget build(final BuildContext context) {
    return wordskiiTableRowInfoList.any((final element) => element.label.isNotEmpty || element.child != null)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (tableTitle != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildBookingSubTitle(
                      tableTitle,
                      context,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              Table(
                columnWidths: {
                  0: const IntrinsicColumnWidth(),
                  1: const IntrinsicColumnWidth(),
                  2: const FlexColumnWidth(1),
                },
                children: [
                  ...wordskiiTableRowInfoList.where((final element) => element.label.isNotEmpty || element.child != null).map(
                    (final e) {
                      return _buildTableRow(
                        context,
                        e.label,
                        e.iconLabel,
                        e.iconData,
                        child: e.child,
                        borderColor: e.borderColor,
                        labelTextAlign: e.labelTextAlign,
                      );
                    },
                  ),
                ],
              ),
            ],
          )
        : const SizedBox();
  }

  TableRow _buildTableRow(
    final BuildContext context,
    final String label,
    final String? iconLabel,
    final IconData icon, {
    final VoidCallback? onPressed,
    final Widget? child,
    final Color? borderColor,
    final TextAlign? labelTextAlign,
  }) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 8,
          ),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  iconLabel?.trim() ?? '',
                  style: SimpleAACText.body1Style,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: borderColor != null ? const EdgeInsets.only(bottom: 16) : const EdgeInsets.all(0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: borderColor ?? Colors.transparent,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: child ??
                          Text(
                            label,
                            style: SimpleAACText.body3Style,
                            textAlign: labelTextAlign ?? TextAlign.start,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingSubTitle(final String? label, final BuildContext context) {
    return Text(
      label ?? '',
      style: tableTitleTextStyle ??
          SimpleAACText.body1Style,
    );
  }
}
