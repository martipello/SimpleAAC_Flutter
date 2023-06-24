import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/extensions/build_context_extension.dart';
import 'package:simple_aac/ui/theme/simple_aac_text.dart';

typedef ExpansionCardBuilder = Widget Function(bool isExpanded);

class ExpansionCard extends StatefulWidget {
  ExpansionCard({
    Key? key,
    this.onTap,
    this.title,
    required this.expandedChildren,
    this.subtitle,
    this.bottomWidgetBuilder,
    this.titleWidget,
    this.subtitleWidget,
    this.borderSide,
  })  : assert(title?.isNotEmpty == true || titleWidget != null),
        super(key: key);

  final String? title;
  final String? subtitle;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final List<Widget> expandedChildren;
  final VoidCallback? onTap;
  final ExpansionCardBuilder? bottomWidgetBuilder;
  final BorderSide? borderSide;

  @override
  State<ExpansionCard> createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  final _expandableController = ExpandableController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _expandableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: widget.borderSide ?? BorderSide(),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: _buildCardBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildCardBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.titleWidget ?? _buildTitle(),
                  if (widget.subtitleWidget != null) widget.subtitleWidget!,
                  if (widget.subtitle != null && widget.subtitle?.isNotEmpty == true) _buildSubtitle(),
                ],
              ),
            ),
            if (widget.expandedChildren.isNotEmpty)
              _buildRotatingIconButton(),
          ],
        ),
        if (widget.expandedChildren.isNotEmpty) _buildExpandable(),
        _buildBottomWidget(),
      ],
    );
  }

  Widget _buildBottomWidget() {
    return widget.bottomWidgetBuilder?.call(_isExpanded) ?? SizedBox();
  }

  Widget _buildExpandable() {
    return Expandable(
      controller: _expandableController,
      collapsed: Row(),
      expanded: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.expandedChildren,
      ),
    );
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        widget.title ?? '',
        style: SimpleAACText.subtitle1Style.copyWith(
          color: context.themeColors.onBackground,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          widget.subtitle ?? '',
          style: SimpleAACText.body1Style.copyWith(
            color: context.themeColors.onBackground,
          ),
        ),
      ),
    );
  }

  Widget _buildRotatingIconButton() {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
      child: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: context.themeColors.onBackground,
        ),
        onPressed: () {
          setState(
            () {
              if (_isExpanded) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
              _isExpanded = !_isExpanded;
              _expandableController.toggle();
            },
          );
        },
      ),
    );
  }
}
