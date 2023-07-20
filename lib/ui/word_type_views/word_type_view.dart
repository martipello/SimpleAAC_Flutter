import 'package:flutter/material.dart';

import '../../api/models/extensions/word_sub_type_extension.dart';
import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/utils/tab_bar_view_model.dart';
import 'word_sub_type_view.dart';

class WordTypeView extends StatefulWidget {
  const WordTypeView({
    required this.wordType,
    super.key,
  });

  final WordType wordType;

  @override
  State<WordTypeView> createState() => _WordTypeViewState();
}

class _WordTypeViewState extends State<WordTypeView> with SingleTickerProviderStateMixin {
  List<WordSubType> get subTypes => widget.wordType.getSubTypes();
  final _tabBarViewModel = getIt.get<TabBarViewModel>();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: subTypes.length, vsync: this);
    _tabController.addListener(
      () {
        _tabBarViewModel.setCurrentTabIndex(_tabController.index);
      },
    );
  }

  @override
  void dispose() {
    _tabBarViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return StreamBuilder<int>(
      stream: _tabBarViewModel.currentTabIndex,
      builder: (final context, final snapshot) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: context.themeColors.secondary,
                  tabs: subTypes
                      .map(
                        (final e) => _buildTab(
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
                        (final e) => WordSubTypeView(
                          wordSubType: e,
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
    final String label,
    final IconData icon,
  ) {
    return Tab(
      text: label,
      icon: Icon(icon),
      iconMargin: EdgeInsets.zero,
      height: 56,
    );
  }
}
