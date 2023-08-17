import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import '../api/models/extensions/word_base_extension.dart';
import 'shared_widgets/multi_image.dart';

import '../api/models/extensions/word_type_extension.dart';
import '../api/models/word.dart';
import '../api/models/word_base.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../view_models/create_word/manage_word_view_model.dart';
import 'dashboard/app_shell.dart';
import 'dashboard/related_words_widget.dart';
import 'pick_image_dialog.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/bottom_button_holder.dart';
import 'shared_widgets/multi_image_id_builder.dart';
import 'shared_widgets/rounded_button.dart';
import 'shared_widgets/simple_aac_text_field.dart';
import 'shared_widgets/simple_aac_tile.dart';
import 'shared_widgets/word_sub_type_picker.dart';
import 'shared_widgets/word_type_picker.dart';

class ManageWordViewArguments {
  ManageWordViewArguments({
    this.word,
    this.heroTag,
  });

  final Word? word;
  final String? heroTag;
}

class ManageWordView extends StatefulWidget {
  static const String routeName = '/create-word';

  @override
  State<ManageWordView> createState() => _ManageWordViewState();
}

class _ManageWordViewState extends State<ManageWordView> {
  ManageWordViewArguments get _createWordViewArguments => context.routeArguments as ManageWordViewArguments;

  String? get heroTag => _createWordViewArguments.heroTag;

  bool get isEditing => _createWordViewArguments.word != null;

  final _formKey = GlobalKey<FormState>();
  final _wordViewModel = getIt.get<ManageWordViewModel>();

  final _wordWordController = TextEditingController();
  final _wordSoundController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addTextListeners();
    Future.delayed(Duration.zero).then(
      (final value) => _wordViewModel.setWord(
        _createWordViewArguments.word,
      ),
    );
  }

  @override
  void dispose() {
    _wordViewModel.dispose();
    _wordWordController.dispose();
    _wordSoundController.dispose();
    super.dispose();
  }

  void _addTextListeners() {
    Future.delayed(Duration.zero).then(
      (final value) {
        _wordWordController.text = _createWordViewArguments.word?.word ?? '';
        _wordSoundController.text = _createWordViewArguments.word?.sound ?? '';
        _wordWordController.addListener(
          () {
            _wordViewModel.setWordWord(
              _wordWordController.text,
            );
          },
        );
        _wordSoundController.addListener(
          () {
            _wordViewModel.setWordSound(
              _wordSoundController.text,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(final BuildContext context) {
    //TODO(MS): scrolling changes the color of the app bar
    return StreamBuilder<Word?>(
      stream: _wordViewModel.wordStream,
      builder: (final context, final snapshot) {
        final _word = snapshot.data ?? _createWordViewArguments.word;
        return FutureBuilder<BuiltList<String>>(
          future: _word?.getWords(),
          builder: (final context, final snapshot) {
            final _wordsWords = snapshot.data ?? BuiltList<String>();
            return Scaffold(
              appBar: SimpleAACAppBar(
                label: isEditing ? 'Edit ${_wordsWords.join(' ')}' : 'Create',
              ),
              body: _buildCreateWordViewBody(
                _word,
              ),
              bottomNavigationBar: _buildBottomButtonBar(),
            );
          },
        );
      },
    );
  }

  Widget _buildCreateWordViewBody(
    final Word? _word,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMediumMargin(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: _buildPickerBar(
              _word,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: _buildSimpleAACTile(
              context,
              _word,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerBar(
    final Word? _word,
  ) {
    return Row(
      children: [
        Expanded(
          child: WordTypePicker(
            wordTypePickerCallBack: _wordViewModel.setWordType,
            wordType: _word?.type,
          ),
        ),
        _buildMediumMargin(),
        Expanded(
          child: WordSubTypePicker(
            wordSubTypePickerCallBack: _wordViewModel.setWordSubType,
            wordType: _word?.type,
            wordSubType: _word?.subType,
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleAACTile(
    final BuildContext context,
    final Word? _word,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          SimpleAACTile(
            border: RoundedRectangleBorder(
              side: BorderSide(
                color: _word?.type.getColor(context) ?? context.themeColors.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _buildWordTileContent(
              _word,
            ),
          ),
          _buildMediumMargin(),
        ],
      ),
    );
  }

  Widget _buildWordTileContent(final Word? _word) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImageAndButtonStack(_word),
          _buildCreateWordWordLabel(_word),
          _buildCreateWordWordSound(_word),
          _buildMediumMargin(),
          _buildExtraRelatedWords(_word),
        ],
      ),
    );
  }

  Widget _buildImageAndButtonStack(
    final Word? _word,
  ) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_word != null)
              _buildCreateWordImage(
                _word,
              ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _buildSpeechButton(),
        ),
      ],
    );
  }

  Widget _buildSpeechButton() {
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

  Widget _buildMediumMargin() {
    return const SizedBox(
      height: 16,
      width: 16,
    );
  }

  Widget _buildCreateWordWordSound(
    final Word? _word,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: SimpleAACTextField(
        labelText: _word?.sound ?? 'Word Sound',
        textController: _wordSoundController,
        validatorMessage: 'Please input a valid word sound.',
        maxLines: 1,
      ),
    );
  }

  Widget _buildCreateWordWordLabel(
    final Word? _word,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
      ),
      child: SimpleAACTextField(
        labelText: _word?.word ?? 'Word Label',
        textController: _wordWordController,
        validatorMessage: 'Please input a valid word',
        maxLines: 1,
      ),
    );
  }

  Widget _buildCreateWordImage(
    final WordBase word,
  ) {
    return Flexible(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 1.0 / 1.0,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                PickImageDialog.show(context);
              },
              child: MultiImageIDBuilder(
                multiImageIDBuilder: (final imageIds) {
                  return imageIds.isNotEmpty
                      ? MultiImage(
                          imageIds: imageIds,
                          fadeIn: false,
                          heroTag: heroTag ?? '',
                        )
                      : FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: context.themeColors.onBackground,
                            ),
                          ),
                        );
                },
                //TODO TERRIBLE HACK please fix
                wordBase: word,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExtraRelatedWords(
    final Word? word,
  ) {
    return StreamBuilder<BuiltList<Word>>(
      stream: _wordViewModel.relatedWords,
      builder: (final context, final snapshot) {
        final relatedWords = snapshot.data ?? BuiltList<Word>();
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: SizedBox(
                height: 32,
                child: word?.extraRelatedWordIds.isNotEmpty == true
                    ? RelatedWordsWidget(
                        relatedWords: relatedWords,
                        onRelatedWordSelected: (final _) {},
                        onRelatedWordIdsChanged: _wordViewModel.setExtraRelatedWords,
                        isExpanded: false,
                        padding: EdgeInsets.only(left: 4, right: 96),
                      )
                    : null,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _buildAddPredictionButton(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddPredictionButton() {
    return FloatingActionButton.small(
      heroTag: null,
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }

  Widget _buildBottomButtonBar() {
    return BottomButtonHolder(
      hasShadow: true,
      child: Row(
        children: [
          Expanded(
            child: _buildCancelButton(context),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: _buildSaveButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return RoundedButton(
      label: 'SAVE',
      onPressed: () {},
    );
  }

  Widget _buildCancelButton(
    final BuildContext context,
  ) {
    return RoundedButton(
      label: 'Cancel',
      fillColor: context.themeColors.secondary,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
