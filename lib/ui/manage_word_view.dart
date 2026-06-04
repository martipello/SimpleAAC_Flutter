import 'package:flutter/material.dart';

import '../api/models/extensions/word_type_extension.dart';
import '../api/models/word.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../extensions/iterable_extension.dart';
import '../services/tts_service.dart';
import '../view_models/create_word/manage_word_view_model.dart';
import 'dashboard/app_shell.dart';
import 'dashboard/related_words_widget.dart';
import 'pick_image_dialog.dart';
import 'word_picker_bottom_sheet.dart' show WordPickerView;
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/bottom_button_holder.dart';
import 'shared_widgets/rounded_button.dart';
import 'shared_widgets/simple_aac_text_field.dart';
import 'shared_widgets/simple_aac_tile.dart';
import 'shared_widgets/word_image.dart';
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
  final _ttsService = getIt.get<TtsService>();

  final _wordWordController = TextEditingController();
  final _wordSoundController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addTextListeners();
    Future.delayed(Duration.zero).then(
      (value) => _wordViewModel.setWord(
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
      (value) {
        _wordWordController.text = _createWordViewArguments.word?.text ?? '';
        _wordSoundController.text = _createWordViewArguments.word?.phoneticOverride ?? '';
        _wordWordController.addListener(
          () => _wordViewModel.setWordText(_wordWordController.text),
        );
        _wordSoundController.addListener(
          () => _wordViewModel.setPhoneticOverride(_wordSoundController.text),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Word?>(
      stream: _wordViewModel.wordStream,
      builder: (context, snapshot) {
        final _word = snapshot.data;
        return Scaffold(
          appBar: SimpleAACAppBar(
            label: isEditing ? 'Edit ${_word?.text ?? ''}' : 'Create',
          ),
          body: _buildCreateWordViewBody(
            _word,
          ),
          bottomNavigationBar: _buildBottomButtonBar(),
        );
      },
    );
  }

  Widget _buildCreateWordViewBody(
    Word? _word,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMediumMargin(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
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
    Word? _word,
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
    BuildContext context,
    Word? _word,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
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

  Widget _buildWordTileContent(Word? _word) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImageAndButtonStack(_word),
          _buildMediumMargin(),
          _buildCreateWordWordLabel(_word),
          _buildMediumMargin(),
          _buildCreateWordWordSound(_word),
          _buildMediumMargin(),
          _buildExtraRelatedWords(_word),
        ],
      ),
    );
  }

  Widget _buildImageAndButtonStack(
    Word? _word,
  ) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
          child: _buildSpeechButton(_word),
        ),
      ],
    );
  }

  Widget _buildSpeechButton(Word? word) {
    return Hero(
      tag: kPlayButtonHeroTag,
      transitionOnUserGestures: true,
      child: StreamBuilder<bool>(
        stream: _ttsService.isSpeaking,
        builder: (context, snapshot) {
          final speaking = snapshot.data ?? false;
          return FloatingActionButton(
            heroTag: null,
            onPressed: word == null
                ? null
                : () {
                    if (speaking) {
                      _ttsService.stop();
                    } else {
                      _ttsService.speakWord(
                        word.phoneticOverride ?? word.text,
                      );
                    }
                  },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                speaking ? Icons.stop_rounded : Icons.play_arrow_rounded,
                key: ValueKey(speaking),
              ),
            ),
          );
        },
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
    Word? _word,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      child: SimpleAACTextField(
        labelText: 'Phonetic Override',
        textController: _wordSoundController,
        validatorMessage: 'Please input a valid word sound.',
        maxLines: 1,
      ),
    );
  }

  Widget _buildCreateWordWordLabel(
    Word? _word,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ),
      child: SimpleAACTextField(
        labelText: 'Word Label',
        textController: _wordWordController,
        validatorMessage: 'Please input a valid word',
        maxLines: 1,
      ),
    );
  }

  Widget _buildCreateWordImage(
    Word? _word,
  ) {
    final imageUri = _word?.imagePaths.firstOrNull() ?? '';
    return ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        clipBehavior: Clip.hardEdge,
        child: AspectRatio(
          aspectRatio: 1.0 / 1.0,
          child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () async {
              final path = await PickImageDialog.show(context);
              if (path != null) _wordViewModel.setImagePath(path);
            },
            child: imageUri.isNotEmpty
                ? Hero(
                    tag: heroTag ?? '',
                    transitionOnUserGestures: true,
                    placeholderBuilder: (_, __, child) => child,
                    child: WordImage(imagePath: imageUri, fit: BoxFit.cover),
                  )
                : FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: context.themeColors.onBackground,
                      ),
                    ),
                  ),
          ),
        ),
                ),
    );
  }

  Widget _buildExtraRelatedWords(
    Word? word,
  ) {
    return StreamBuilder<List<Word>>(
      stream: _wordViewModel.relatedWords,
      builder: (context, snapshot) {
        final relatedWords = snapshot.data ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (word?.extraRelatedWordIds.isNotEmpty == true)
              RelatedWordsWidget(
                relatedWords: relatedWords,
                onRelatedWordSelected: (_) {},
                onRelatedWordIdsChanged: _wordViewModel.setExtraRelatedWords,
                isExpanded: true,
              ),
            _buildAddPredictionButton(),
          ],
        );
      }
    );
  }

  Widget _buildAddPredictionButton() {
    return TextButton.icon(
      onPressed: () async {
        final current = _wordViewModel.wordStream.valueOrNull?.extraRelatedWordIds ?? [];
        final result = await WordPickerView.show(context, existingWordIds: current);
        if (result != null) _wordViewModel.setExtraRelatedWords(result);
      },
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Add prediction'),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
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
    return StreamBuilder<bool>(
      stream: _wordViewModel.isValid,
      builder: (context, snapshot) {
        final valid = snapshot.data ?? false;
        return RoundedButton(
          label: 'Save',
          onPressed: valid
              ? () async {
                  await _wordViewModel.saveWord();
                  if (!context.mounted) return;
                  if (isEditing) {
                    Navigator.of(context).popUntil((route) => route.settings.name == AppShell.routeName);
                  } else {
                    Navigator.of(context).pop(_wordViewModel.wordStream.valueOrNull);
                  }
                }
              : null,
        );
      },
    );
  }

  Widget _buildCancelButton(
    BuildContext context,
  ) {
    return RoundedButton(
      label: 'Cancel',
      isFilled: false,
      onPressed: () {
        if (isEditing) {
          Navigator.of(context).popUntil((route) => route.settings.name == AppShell.routeName);
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
