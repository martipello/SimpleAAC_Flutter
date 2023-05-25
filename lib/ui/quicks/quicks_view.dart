import 'package:flutter/material.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../view_models/utils/tab_bar_view_model.dart';
import 'favourites_view.dart';

class QuicksView extends StatefulWidget {
  @override
  State<QuicksView> createState() => _QuicksViewState();
}

class _QuicksViewState extends State<QuicksView> with SingleTickerProviderStateMixin {
  final _tabBarViewModel = getIt.get<TabBarViewModel>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
  Widget build(BuildContext context) {
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
                  indicatorColor: context.themeColors.secondary,
                  tabs: [
                    _buildTab(
                      'FAVOURITES',
                      Icons.favorite_outline_rounded,
                    ),
                    _buildTab(
                      'PRONOUN',
                      Icons.people_outlined,
                    ),
                    _buildTab(
                      'CONJUNCTIONS',
                      Icons.add_outlined,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FavouritesView(),
                    const Text('PRONOUN'),
                    const Text('CONJUNCTIONS'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(String label, IconData icon) {
    return Tab(
      text: label,
      icon: Icon(icon),
      iconMargin: EdgeInsets.zero,
      height: 56,
    );
  }
}
