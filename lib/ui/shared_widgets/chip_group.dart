import 'package:flutter/cupertino.dart';

class ChipGroup extends StatelessWidget {
  const ChipGroup({
    required this.chips,
  });

  final List<Widget> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: chips.toList(),
    );
  }
}
