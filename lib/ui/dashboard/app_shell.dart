import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../api/models/word.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../flavors.dart';
import '../../services/shared_preferences_service.dart';
import '../../view_models/selected_words_view_model.dart';
import '../intro/intro_page.dart';
import '../manage_word_view.dart';
import '../quicks/quicks_view.dart';
import '../settings_view.dart';
import '../shared_widgets/app_bar.dart';
import '../shared_widgets/simple_aac_loading_widget.dart';
import '../theme/simple_aac_text.dart';
import 'predictions_widget.dart';
import 'sentence_widget.dart';

const kPlayButtonHeroTag = 'play-button';

class AppShell extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final sharedPreferences = getIt.get<SharedPreferencesService>();
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedWordsViewModel.selectedWords.listen((value) {
      print('selectedWordsStream WORD $value');
    });
    selectedWordsViewModel.predictions.listen((value) {
      print('predictionsForSelectedWord WORD $value');
    });
  }

  @override
  void dispose() {
    sharedPreferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: sharedPreferences.isFirstTime(),
      builder: (context, snapshot) {
        final isFirstTime = snapshot.data;
        if(isFirstTime == null) {
          return const Center(child: SimpleAACLoadingWidget(),);
        }
        if (isFirstTime == true) {
          return IntroPage();
        }
        return _buildAppShell();
      },
    );
  }

  Widget _buildAppShell() {
    return Scaffold(
      appBar: _buildSimpleAACAppBar(),
      body: _buildAppBody(),
      floatingActionButton: _buildAddWordActionButton(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeroHolder(),
        [
          QuicksView(),
          QuicksView(),
          QuicksView(),
          QuicksView(),
        ].elementAt(_selectedIndex)
      ],
    );
  }

  Widget _buildHeroHolder() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SentenceWidget(),
            _buildPredictions(),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPlaySentenceActionButton(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPredictions() {
    return StreamBuilder<BuiltList<Word>>(
      stream: selectedWordsViewModel.predictions,
      builder: (context, snapshot) {
        final predictions = snapshot.data ?? BuiltList();
        return SizedBox(
          height: 48,
          child: PredictionsWidget(
            predictions: predictions,
            onPredictionsChanged: selectedWordsViewModel.setPredictions,
          ),
        );
      },
    );
  }

  Widget _buildPlaySentenceActionButton() {
    return Hero(
      tag: kPlayButtonHeroTag,
      transitionOnUserGestures: true,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        child: const Icon(
          Icons.play_arrow,
        ),
      ),
    );
  }

  Widget _buildAddWordActionButton() {
    return SpeedDial(
      spaceBetweenChildren: 4,
      buttonSize: const Size(48, 48),
      childrenButtonSize: const Size(46, 46),
      spacing: 4,
      children: [
        SpeedDialChild(
          onTap: () {
            Navigator.of(context).pushNamed(
              ManageWordView.routeName,
              arguments: ManageWordViewArguments(),
            );
          },
          child: const FloatingActionButton(
            onPressed: null,
            heroTag: null,
            child: Icon(Icons.add),
          ),
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.of(context).pushNamed(
              ManageWordView.routeName,
              arguments: ManageWordViewArguments(
                word: null,
              ),
            );
          },
          child: const FloatingActionButton(
            onPressed: null,
            heroTag: null,
            child: Icon(Icons.group_add_rounded),
          ),
        ),
      ],
      useRotationAnimation: true,
      icon: Icons.add,
      activeIcon: Icons.close,
    );
  }

  SimpleAACAppBar _buildSimpleAACAppBar() {
    return SimpleAACAppBar(
      label: F.title,
      actions: [
        _buildSearchAppBarAction(),
        _buildMenuAppBarAction(),
      ],
    );
  }

  Widget _buildMenuAppBarAction() {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {},
        icon: _buildMenuButton(),
      );
  }

  Widget _buildSearchAppBarAction() {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {},
        icon: const Icon(
          Icons.search_rounded,
        ),
      );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(
        color: context.themeColors.secondary,
      ),
      showUnselectedLabels: false,
      iconSize: 24,
      unselectedFontSize: 0,
      selectedFontSize: SimpleAACText.body3Style.fontSize ?? 14,
      elevation: 12,
      items: _bottomNavigationBarItems(),
      currentIndex: _selectedIndex,
      selectedItemColor: context.themeColors.secondary,
      unselectedItemColor: context.themeColors.primary,
      onTap: (index) {
        setState(
          () {
            _selectedIndex = index;
          },
        );
      },
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'QUICKS',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'NOUNS',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'VERBS',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'OTHER',
      ),
    ];
  }

  Widget _buildMenuButton() {
    return PopupMenuButton(
      onSelected: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed(SettingsView.routeName);
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: _buildMenuItem(
              context,
              'Settings',
              Icons.settings,
            ),
          ),
          PopupMenuItem(
            onTap: () {},
            child: _buildMenuItem(
              context,
              'Send',
              Icons.send,
            ),
          ),
          PopupMenuItem(
            onTap: () {},
            child: _buildMenuItem(
              context,
              'Share',
              Icons.share,
            ),
          ),
          PopupMenuItem(
            onTap: () {},
            child: _buildMenuItem(
              context,
              'About',
              Icons.info,
            ),
          ),
        ];
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: context.themeColors.onBackground,
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: Text(
            label,
            style: SimpleAACText.body4Style,
          ),
        ),
      ],
    );
  }
}
