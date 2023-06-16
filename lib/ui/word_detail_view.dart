import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../extensions/build_context_extension.dart';
import '../api/models/word.dart';
import '../dependency_injection_container.dart';
import '../extensions/iterable_extension.dart';
import '../view_models/words_view_model.dart';
import 'dashboard/app_shell.dart';
import 'dashboard/related_words_widget.dart';
import 'manage_word_view.dart';
import 'shared_widgets/overlay_button.dart';
import 'shared_widgets/simple_aac_dialog.dart';
import 'shared_widgets/simple_aac_table.dart';
import 'theme/simple_aac_text.dart';

class WordDetailViewArguments {
  WordDetailViewArguments({
    required this.word,
    required this.heroTag,
  });

  final Word word;
  final String heroTag;
}

const kImageHeight = 350.0;

class WordDetailView extends StatefulWidget {
  static const String routeName = '/word-detail';

  @override
  State<WordDetailView> createState() => _WordDetailViewState();
}

class _WordDetailViewState extends State<WordDetailView> {
  final wordViewModel = getIt.get<WordsViewModel>();
  WordDetailViewArguments get _wordDetailViewArguments => context.routeArguments as WordDetailViewArguments;

  Word get _word => _wordDetailViewArguments.word;

  String get heroTag => _wordDetailViewArguments.heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                _buildWordDetailImage(_word),
                _buildSpeechActionButton(),
                Padding(
                  padding: EdgeInsets.only(top: context.topPadding),
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OverlayButton(
                          onTap: Navigator.of(context).pop,
                          iconData: Icons.arrow_back,
                          size: const Size(
                            kToolbarHeight,
                            kToolbarHeight,
                          ),
                        ),
                        OverlayButton(
                          onTap: Navigator.of(context).pop,
                          iconData: _word.isFavourite == true ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                          size: const Size(
                            kToolbarHeight,
                            kToolbarHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Details',
                    style: SimpleAACText.subtitle3Style.copyWith(
                      color: context.themeColors.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SimpleAACTable(
                    wordskiiTableRowInfoList: [
                      SimpleAACTableRowInfo(
                        _word.word,
                        Icons.title,
                        'Word : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.sound,
                        Icons.volume_up,
                        'Speak : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.subType.name,
                        Icons.title,
                        'Description : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.type.name,
                        Icons.title,
                        'Type : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.usageCount != null ? '${_word.usageCount?.toString()} times' : '0 times',
                        Icons.title,
                        'Used : ',
                      ),
                      SimpleAACTableRowInfo(
                        '',
                        Icons.star_rounded,
                        'Keystage : ',
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: context.themeColors.onBackground,
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: context.themeColors.onBackground,
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: context.themeColors.onBackground,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Predictions : ',
                    style: SimpleAACText.subtitle3Style.copyWith(
                      color: context.themeColors.onBackground,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FutureBuilder<BuiltList<Word>>(
                    future: wordViewModel.getWordsForIds(_word.extraRelatedWordIds),
                    builder: (context, snapshot) {
                      final extraRelatedWords = snapshot.data ?? BuiltList();
                      return RelatedWordsWidget(
                        relatedWords: extraRelatedWords,
                        isExpanded: true,
                      );
                    }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildEditDeleteWordActionButton(
        _word,
      ),
    );
  }

  Widget _buildSpeechActionButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Hero(
            tag: kPlayButtonHeroTag,
            transitionOnUserGestures: true,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: const Icon(
                Icons.play_arrow,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWordDetailImage(Word _word) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 24,
      ),
      child: Hero(
        tag: heroTag,
        transitionOnUserGestures: true,
        child: Image.asset(
          _word.imageList.firstOrNull() ?? 'assets/images/sealstudioslogocenter.png',
          fit: BoxFit.cover,
          height: kImageHeight,
          width: context.screenWidth,
        ),
      ),
    );
  }

  Widget _buildEditDeleteWordActionButton(
    Word word,
  ) {
    return SpeedDial(
      spaceBetweenChildren: 4,
      buttonSize: const Size(48, 48),
      childrenButtonSize: const Size(46, 46),
      spacing: 4,
      children: [
        SpeedDialChild(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
              ManageWordView.routeName,
              arguments: ManageWordViewArguments(
                word: word,
                heroTag: heroTag,
              ),
            );
          },
          child: const FloatingActionButton(
            onPressed: null,
            heroTag: null,
            child: Icon(Icons.edit),
          ),
        ),
        SpeedDialChild(
          onTap: () async {
            final delete = await SimpleAACDialog(
              title: 'Delete',
              content: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Are you sure you want to delete this word?',
                  style: SimpleAACText.body4Style,
                ),
              ),
              dialogActions: [
                DialogAction(
                  actionText: 'Cancel',
                  actionVoidCallback: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                DialogAction(
                  actionText: 'Delete',
                  actionVoidCallback: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ).show(context);
            if (delete == true) {
              //TODO delete card
            }
          },
          child: const FloatingActionButton(
            onPressed: null,
            heroTag: null,
            child: Icon(Icons.delete),
          ),
        ),
      ],
      useRotationAnimation: true,
      icon: Icons.edit,
      activeIcon: Icons.close,
    );
  }

}
