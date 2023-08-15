import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tuple/tuple.dart';

import '../../extensions/build_context_extension.dart';
import '../api/models/extensions/word_base_extension.dart';
import '../api/models/sentence.dart';
import '../api/models/word.dart';
import '../api/models/word_base.dart';
import '../dependency_injection_container.dart';
import '../view_models/words_view_model.dart';
import 'dashboard/app_shell.dart';
import 'dashboard/related_words_widget.dart';
import 'manage_word_view.dart';
import 'shared_widgets/multi_image.dart';
import 'shared_widgets/multi_image_id_builder.dart';
import 'shared_widgets/overlay_button.dart';
import 'shared_widgets/simple_aac_dialog.dart';
import 'shared_widgets/simple_aac_table.dart';
import 'theme/simple_aac_text.dart';

class WordBaseDetailViewArguments {
  WordBaseDetailViewArguments({
    required this.word,
    this.heroTag,
  });

  final WordBase word;
  final String? heroTag;
}

const kImageHeight = 350.0;
const simpleAACLogo = 'assets/images/sealstudioslogocenter.png';

class WordBaseDetailView extends StatefulWidget {
  static const String routeName = '/word-detail';

  @override
  State<WordBaseDetailView> createState() => _WordBaseDetailViewState();
}

//TODO decide how to display sentences
class _WordBaseDetailViewState extends State<WordBaseDetailView> {
  final wordViewModel = getIt.get<WordsViewModel>();

  WordBaseDetailViewArguments get _wordDetailViewArguments => context.routeArguments as WordBaseDetailViewArguments;

  WordBase get _wordBase => _wordDetailViewArguments.word;

  // WordBase get word => _wordDetailViewArguments.word;
  //
  // Sentence get sentence => _wordDetailViewArguments.word as Sentence;
  //
  // bool get isSentence => _wordDetailViewArguments.word is Sentence;
  //
  // bool get isWord => _wordDetailViewArguments.word is Word;

  String? get heroTag => _wordDetailViewArguments.heroTag;

  double get toolbarMinusPadding => kToolbarHeight - 16;

  @override
  Widget build(final BuildContext context) {
    //TODO(MS): refactor this to keep the app bar icons visible when scrolling in some way
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                _buildWordBaseDetailImage(),
                _buildSpeechActionButton(),
                _buildWordBaseAppBar(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDetailsLabel(),
                  _buildSmallMargin(),
                  _buildDetailsTable(),
                  _buildMediumMargin(),
                  _buildRelatedWords(),
                  _buildExtraLargeMargin(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildEditAndDeleteWordActionButtons(),
    );
  }

  Widget _buildWordBaseDetailImage() {
    return Container(
      height: kImageHeight,
      padding: const EdgeInsets.only(
        bottom: 24,
      ),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    return MultiImageIDBuilder(
      multiImageIDBuilder: (final imageIds) {
        return MultiImage(
          imageIds: imageIds,
          heroTag: heroTag,
          fadeIn: false,
        );
      },
      wordBase: _wordBase,
    );
  }

  Widget _buildSpeechActionButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
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

  Widget _buildWordBaseAppBar() {
    return Padding(
      padding: EdgeInsets.only(top: context.topPadding),
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: OverlayButton(
                onTap: Navigator.of(context).pop,
                iconData: Icons.arrow_back,
                size: Size(
                  toolbarMinusPadding,
                  toolbarMinusPadding,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: OverlayButton(
                onTap: Navigator.of(context).pop,
                iconData: _wordBase.isFavourite == true ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                size: Size(
                  toolbarMinusPadding,
                  toolbarMinusPadding,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsLabel() {
    return Text(
      'Details',
      style: SimpleAACText.subtitle3Style.copyWith(
        color: context.themeColors.onBackground,
      ),
    );
  }

  Widget _buildDetailsTable() {
    final wordBase = _wordBase;
    return FutureBuilder<BuiltList<Tuple2<String, String>>>(
      future: wordBase.getWordsAndSounds(),
      builder: (final context, final snapshot) {
        final wordsAndSounds = snapshot.data ?? BuiltList();
        return SimpleAACTable(
          wordskiiTableRowInfoList: [
            SimpleAACTableRowInfo(
              wordsAndSounds.map((final wordAndSound) => wordAndSound.item1).join(' '),
              Icons.title,
              'Word : ',
            ),
            SimpleAACTableRowInfo(
              wordsAndSounds.map((final wordAndSound) => wordAndSound.item2).join(' '),
              Icons.volume_up,
              'Speak : ',
            ),
            SimpleAACTableRowInfo(
              wordBase.subType.name,
              Icons.title,
              'Description : ',
            ),
            SimpleAACTableRowInfo(
              wordBase.type.name,
              Icons.title,
              'Type : ',
            ),
            SimpleAACTableRowInfo(
              wordBase.usageCount != null ? '${wordBase.usageCount?.toString()} times' : '0 times',
              Icons.title,
              'Used : ',
            ),
            if (wordBase is Word)
              SimpleAACTableRowInfo(
                '',
                Icons.star_rounded,
                'Keystage : ',
                child: Row(
                  children: List.generate(
                    wordBase.keyStage?.toInt() ?? 0,
                    (final _) => Icon(
                      Icons.star_rounded,
                      color: context.themeColors.onBackground,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildRelatedWords() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Related words : ',
          style: SimpleAACText.subtitle3Style.copyWith(
            color: context.themeColors.onBackground,
          ),
        ),
        _buildMediumMargin(),
        FutureBuilder<BuiltList<Word>>(
          future: _wordBase.getRelatedWords(),
          builder: (final context, final snapshot) {
            final extraRelatedWords = snapshot.data ?? BuiltList();
            return RelatedWordsWidget(
              onRelatedWordSelected: (final _) {},
              relatedWords: extraRelatedWords,
              isExpanded: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEditAndDeleteWordActionButtons() {
    return SpeedDial(
      spaceBetweenChildren: 4,
      buttonSize: const Size(48, 48),
      childrenButtonSize: const Size(46, 46),
      spacing: 4,
      children: [
        _buildEditActionButton(),
        _buildDeleteActionButton(),
      ],
      useRotationAnimation: true,
      icon: Icons.edit,
      activeIcon: Icons.close,
    );
  }

  SpeedDialChild _buildEditActionButton() {
    return SpeedDialChild(
      onTap: () {
        //TODO decide how to edit sentences, maybe a new view? maybe the same as word groups
        Navigator.of(context).pushReplacementNamed(
          ManageWordView.routeName,
          arguments: ManageWordViewArguments(
            word: _wordBase,
            heroTag: heroTag,
          ),
        );
      },
      child: const FloatingActionButton(
        onPressed: null,
        heroTag: null,
        child: Icon(Icons.edit),
      ),
    );
  }

  SpeedDialChild _buildDeleteActionButton() {
    return SpeedDialChild(
      onTap: () async {
        final delete = await _buildDeleteDialog().show(context);
        if (delete == true) {
          //TODO delete card
        }
      },
      child: const FloatingActionButton(
        onPressed: null,
        heroTag: null,
        child: Icon(Icons.delete),
      ),
    );
  }

  Widget _buildDeleteDialog() {
    return SimpleAACDialog(
      title: 'Delete',
      content: const Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          'Are you sure you want to delete this word?',
          style: SimpleAACText.body1Style,
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
    );
  }

  Widget _buildExtraLargeMargin() {
    return const SizedBox(
      height: 96,
    );
  }

  Widget _buildSmallMargin() {
    return const SizedBox(
      height: 8,
    );
  }

  Widget _buildMediumMargin() {
    return const SizedBox(
      height: 16,
    );
  }
}
