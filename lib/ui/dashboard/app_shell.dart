import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../api/models/word.dart';
import '../../api/models/word_type.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/string_extension.dart';
import '../../flavors.dart';
import '../../services/shared_preferences_service.dart';
import '../../view_models/selected_words_view_model.dart';
import '../intro/intro_page.dart';
import '../manage_word_view.dart';
import '../settings_view.dart';
import '../shared_widgets/app_bar.dart';
import '../theme/simple_aac_text.dart';
import '../word_type_views/word_type_view.dart';
import 'related_words_widget.dart';
import 'sentence_widget.dart';

const kPlayButtonHeroTag = 'play-button';

class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    this.title,
    this.isHome = true,
  });

  static const routeName = '/dashboard';

  final String? title;
  final bool isHome;

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with SingleTickerProviderStateMixin {
  final sharedPreferences = getIt.get<SharedPreferencesService>();
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedWordsViewModel.selectedWords.listen((value) {
      // print('selectedWordsStream WORD $value');
    });
    selectedWordsViewModel.relatedWords.listen((value) {
      // print('predictionsForSelectedWord WORD $value');
    });
  }

  @override
  void dispose() {
    // _expandedGroupRevealAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFirstTime = sharedPreferences.isFirstTime;
    if (isFirstTime == true) {
      return IntroPage();
    }
    return _buildAppShell();
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
        WordType.values
            .map(
              (wordType) => WordTypeView(
                wordType: wordType,
              ),
            )
            .elementAt(_selectedIndex)
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
            _buildRelatedWords(),
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

  Widget _buildRelatedWords() {
    return StreamBuilder<BuiltList<Word>>(
      stream: selectedWordsViewModel.relatedWords,
      builder: (context, snapshot) {
        final relatedWords = snapshot.data ?? BuiltList();
        return SizedBox(
          height: 48,
          child: RelatedWordsWidget(
            relatedWords: relatedWords,
            onRelatedWordIdsChanged: selectedWordsViewModel.setRelatedWordsForWordIds,
            onRelatedWordSelected: selectedWordsViewModel.addSelectedWord,
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
      label: widget.title ?? F.title,
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
      showUnselectedLabels: false,
      elevation: 12,
      items: _bottomNavigationBarItems(),
      currentIndex: _selectedIndex,
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
    return WordType.values
        .map(
          (e) => BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: e.name.capitalize(),
          ),
        )
        .toList();
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
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: Text(
            label,
            style: SimpleAACText.body1Style,
          ),
        ),
      ],
    );
  }
}
