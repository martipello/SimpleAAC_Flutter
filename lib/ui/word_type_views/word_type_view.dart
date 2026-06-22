import 'package:flutter/material.dart';

import '../../api/models/extensions/word_sub_type_extension.dart';
import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/utils/tab_bar_view_model.dart';
import '../shared_widgets/word_tile.dart';
import 'core_word_view.dart';
import 'word_sub_type_view.dart';

class WordTypeView extends StatefulWidget {
  const WordTypeView({super.key, required this.wordType, this.wordTapCallBack, this.selectedWordIds, this.initialSubType});

  final WordType wordType;
  final WordCallBack? wordTapCallBack;
  final Set<String>? selectedWordIds;
  final WordSubType? initialSubType;

  @override
  State<WordTypeView> createState() => _WordTypeViewState();
}

class _WordTypeViewState extends State<WordTypeView> with TickerProviderStateMixin {
  List<WordSubType> get subTypes => widget.wordType.getSubTypes();
  final _tabBarViewModel = getIt.get<TabBarViewModel>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = _buildController();
  }

  @override
  void didUpdateWidget(WordTypeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.wordType != widget.wordType) {
      _tabController.dispose();
      _tabController = _buildController();
    }
  }

  TabController _buildController() {
    final initialIndex = widget.initialSubType != null
        ? subTypes.indexOf(widget.initialSubType!).clamp(0, subTypes.length - 1)
        : 0;
    final controller = TabController(length: subTypes.length, vsync: this, initialIndex: initialIndex < 0 ? 0 : initialIndex);
    controller.addListener(() {
      _tabBarViewModel.setCurrentTabIndex(controller.index);
    });
    return controller;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabBarViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (subTypes.isEmpty) {
      return const Expanded(child: CoreWordView());
    }
    return StreamBuilder<int>(
      stream: _tabBarViewModel.currentTabIndex,
      builder: (context, snapshot) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  padding: EdgeInsets.zero,
                  indicatorColor: context.themeColors.secondary,
                  tabs: subTypes
                      .map(
                        (e) => _buildTab(
                          e.name,
                          e.getIcon(),
                        ),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: subTypes
                      .map(
                        (e) => WordSubTypeView(
                          key: ValueKey('${widget.wordType.name}-${e.name}'),
                          wordSubType: e,
                          wordTapCallBack: widget.wordTapCallBack,
                          selectedWordIds: widget.selectedWordIds,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(
    String label,
    IconData icon,
  ) {
    return Tab(
      text: label,
      icon: Icon(icon),
      iconMargin: EdgeInsets.zero,
      height: 56,
    );
  }
}
