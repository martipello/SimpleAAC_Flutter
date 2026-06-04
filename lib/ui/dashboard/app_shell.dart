import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/models/extensions/word_type_extension.dart';
import '../../api/models/word.dart';
import '../../api/models/word_sub_type.dart';
import '../../api/models/word_type.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/iterable_extension.dart';
import '../../extensions/string_extension.dart';
import '../../flavors.dart';
import '../../services/shared_preferences_service.dart';
import '../../view_models/selected_words_view_model.dart';
import '../intro/intro_page.dart';
import '../manage_word_view.dart';
import '../settings_view.dart';
import '../create_word_group_view.dart';
import '../word_groups_view.dart';
import '../search/word_search_delegate.dart';
import '../shared_widgets/app_bar.dart';
import '../shared_widgets/simple_aac_chip.dart';
import '../shared_widgets/word_image.dart';
import '../theme/simple_aac_text.dart';
import '../word_type_views/group_word_view.dart';
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

class _AppShellState extends State<AppShell> {
  final sharedPreferences = getIt.get<SharedPreferencesService>();
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();

  var _selectedIndex = 0;
  WordSubType? _pendingSubType;

  @override
  void initState() {
    super.initState();
    selectedWordsViewModel.selectedWords.listen((value) {
      print('selectedWordsStream WORD ${value.map((s) => s.word)}');
    });
    selectedWordsViewModel.relatedWords.listen((value) {
      print('predictionsForSelectedWord WORD $value');
    });
  }

  @override
  void dispose() {
    if (widget.isHome) {
      sharedPreferences.dispose();
    }
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
        if (_selectedIndex >= WordType.values.length)
          const Expanded(child: GroupWordView())
        else
          WordTypeView(
            key: ValueKey('$_selectedIndex-$_pendingSubType'),
            wordType: WordType.values[_selectedIndex],
            initialSubType: _pendingSubType,
          ),
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
            _buildAiPredictions(),
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
    return StreamBuilder<List<Word>>(
      stream: selectedWordsViewModel.relatedWords,
      builder: (context, snapshot) {
        final relatedWords = snapshot.data ?? [];
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

  Widget _buildAiPredictions() {
    return ListenableBuilder(
      listenable: sharedPreferences,
      builder: (context, _) {
        if (!sharedPreferences.aiPredictionsEnabled) return const SizedBox.shrink();
        return StreamBuilder<List<WordSlot>>(
          stream: selectedWordsViewModel.selectedWords,
          builder: (context, sentenceSnap) {
            final hasWords = sentenceSnap.data?.isNotEmpty ?? false;
            if (!hasWords) return const SizedBox.shrink();
            return StreamBuilder<List<Word>?>(
              stream: selectedWordsViewModel.aiPredictions,
              builder: (context, predSnap) {
                final predictions = predSnap.data; // null=loading, []=no results, [...]= results
                return _buildAiRow(context, predictions);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAiRow(BuildContext context, List<Word>? predictions) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 16,
              color: context.themeColors.primary.withOpacity(0.7),
            ),
          ),
          Expanded(
            child: predictions == null
                ? _buildAiLoadingShimmer(context)
                : predictions.isEmpty
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'No AI predictions',
                          style: TextStyle(
                            color: context.themeColors.onSurface.withOpacity(0.4),
                            fontSize: 13,
                          ),
                        ),
                      )
                    : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(right: 96),
                    itemCount: predictions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final word = predictions[index];
                      return SimpleAACChip(
                        label: word.text,
                        icon: ClipOval(
                          child: WordImage(
                            imagePath: word.imagePaths.firstOrNull(),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        chipType: ChipType.normal,
                        onTap: () => selectedWordsViewModel.addSelectedWord(word),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiLoadingShimmer(BuildContext context) {
    final base = context.themeColors.surfaceContainerHighest;
    final highlight = context.themeColors.surfaceContainerLow;
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, __) => Container(
          width: 72,
          height: 32,
          decoration: BoxDecoration(
            color: base,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaySentenceActionButton() {
    return StreamBuilder<bool>(
      stream: selectedWordsViewModel.isSpeaking,
      builder: (context, snapshot) {
        final speaking = snapshot.data ?? false;
        return Hero(
          tag: kPlayButtonHeroTag,
          transitionOnUserGestures: true,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: selectedWordsViewModel.toggleSpeak,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                speaking ? Icons.stop_rounded : Icons.play_arrow_rounded,
                key: ValueKey(speaking),
              ),
            ),
          ),
        );
      },
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
          label: 'Add group',
          child: const Icon(Icons.playlist_add),
          onTap: () => Navigator.of(context).pushNamed(
            CreateWordGroupView.routeName,
            arguments: const CreateWordGroupViewArguments(),
          ),
        ),
        SpeedDialChild(
          label: 'Add word',
          child: const Icon(Icons.add_photo_alternate_outlined),
          onTap: () async {
            final word = await Navigator.of(context).pushNamed(
              ManageWordView.routeName,
              arguments: ManageWordViewArguments(),
            ) as Word?;
            if (word != null && mounted) {
              setState(() {
                _selectedIndex = WordType.values.indexOf(word.type);
                _pendingSubType = word.subType;
              });
            }
          },
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
      icon: const Icon(Icons.search_rounded),
      onPressed: () => showSearch(
        context: context,
        delegate: WordSearchDelegate(
          getIt.get(),
          selectedWordsViewModel,
        ),
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
    return [
      ...WordType.values.map(
        (e) => BottomNavigationBarItem(
          icon: Icon(e.getIcon()),
          label: e.name.capitalize(),
        ),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.playlist_play_rounded),
        label: 'Groups',
      ),
    ];
  }

  Widget _buildMenuButton() {
    return PopupMenuButton(
      onSelected: (index) {
        if (index == 0) {
          Navigator.of(context).pushNamed(SettingsView.routeName);
        } else if (index == 1) {
          Navigator.of(context).pushNamed(WordGroupsView.routeName);
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
            value: 1,
            child: _buildMenuItem(
              context,
              'My groups',
              Icons.playlist_play_rounded,
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
