import 'package:flutter/material.dart';
import '../../extensions/build_context_extension.dart';

class ExpansionView extends StatefulWidget {
  const ExpansionView({
    required this.child,
    this.expandedTitle,
    required this.title,
    this.alignment = MainAxisAlignment.center,
  });

  final Widget child;
  final Widget? expandedTitle;
  final Widget title;
  final MainAxisAlignment alignment;

  @override
  _ExpansionViewState createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView> with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: _isExpanded ? double.infinity : 50,
                ),
                child: widget.child,
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  height: _isExpanded ? 0 : 60,
                  duration: const Duration(milliseconds: 100),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white24, Color(0x90FFFFFF)],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (_isExpanded) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: widget.alignment,
              children: <Widget>[
                getTitle(),
                const SizedBox(
                  width: 8,
                ),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getTitle() {
    if (_isExpanded) {
      return widget.expandedTitle ?? widget.title;
    } else {
      return widget.title;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
