import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../api/models/extensions/word_type_extension.dart';
import '../api/models/word.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../services/image_path_service.dart';
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
  ManageWordViewArguments get _args =>
      (context.routeArguments as ManageWordViewArguments?) ?? ManageWordViewArguments();

  late final _wordViewModel = getIt.get<ManageWordViewModel>();
  final _ttsService = getIt.get<TtsService>();
  final _formKey = GlobalKey<FormState>();
  final _wordWordController = TextEditingController();
  final _wordSoundController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final args = _args;
      _wordWordController.text = args.word?.text ?? '';
      _wordSoundController.text = args.word?.phoneticOverride ?? '';
      _wordWordController.addListener(
        () => _wordViewModel.setWordText(_wordWordController.text),
      );
      _wordSoundController.addListener(
        () => _wordViewModel.setPhoneticOverride(_wordSoundController.text),
      );
      _wordViewModel.setWord(args.word);
    });
  }

  @override
  void dispose() {
    _wordViewModel.dispose();
    _wordWordController.dispose();
    _wordSoundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = _args;
    return StreamBuilder<Word?>(
      stream: _wordViewModel.wordStream,
      builder: (context, snapshot) {
        final word = snapshot.data;
        final isLoading = !snapshot.hasData;
        return Scaffold(
          appBar: SimpleAACAppBar(
            label: args.word != null ? 'Edit ${word?.text ?? ''}' : 'Create Word',
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                      child: isLoading
                          ? _buildPickerShimmer(context)
                          : _buildPickerBar(word),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Form(
                            key: _formKey,
                            child: SimpleAACTile(
                              border: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: word?.type.getColor(context) ??
                                      context.themeColors.primary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: _buildWordTileContent(word, args.heroTag),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomButtonBar(
            isLoading: isLoading,
            args: args,
          ),
        );
      },
    );
  }

  Widget _buildPickerBar(Word? word) {
    return Row(
      children: [
        Expanded(
          child: WordTypePicker(
            wordTypePickerCallBack: _wordViewModel.setWordType,
            wordType: word?.type,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: WordSubTypePicker(
            wordSubTypePickerCallBack: _wordViewModel.setWordSubType,
            wordType: word?.type,
            wordSubType: word?.subType,
          ),
        ),
      ],
    );
  }

  Widget _buildPickerShimmer(BuildContext context) {
    final base = context.themeColors.surfaceContainerHighest;
    final highlight = context.themeColors.surfaceContainerLow;
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordTileContent(Word? word, String? heroTag) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildImageAndButtonStack(word, heroTag),
          const SizedBox(height: 16),
          _buildCreateWordWordLabel(),
          const SizedBox(height: 16),
          _buildCreateWordWordSound(),
          const SizedBox(height: 16),
          _buildExtraRelatedWords(word),
        ],
      ),
    );
  }

  Widget _buildImageAndButtonStack(Word? word, String? heroTag) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCreateWordImage(word, heroTag),
            const SizedBox(height: 24),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _buildSpeechButton(word),
        ),
      ],
    );
  }

  Widget _buildCreateWordImage(Word? word, String? heroTag) {
    final imageUri = word != null ? getIt<ImagePathService>().resolve(word) : null;
    final hasImage = imageUri?.isNotEmpty ?? false;
    return AspectRatio(
      aspectRatio: 1 / 1.3,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        clipBehavior: Clip.hardEdge,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () async {
              final path = await PickImageDialog.show(context);
              if (path != null) _wordViewModel.setImagePath(path);
            },
            child: hasImage && heroTag != null
                ? Hero(
                    tag: heroTag,
                    transitionOnUserGestures: true,
                    // Empty placeholder so the image doesn't show twice during transition
                    placeholderBuilder: (_, __, ___) => const SizedBox.shrink(),
                    child: WordImage(imagePath: imageUri, fit: BoxFit.cover),
                  )
                : hasImage
                    ? WordImage(imagePath: imageUri, fit: BoxFit.cover)
                    : Center(
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 48,
                          color: context.themeColors.onSurface,
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeechButton(Word? word) {
    return StreamBuilder<bool>(
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
    );
  }

  Widget _buildCreateWordWordLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SimpleAACTextField(
        labelText: 'Word Label',
        textController: _wordWordController,
        validatorMessage: 'Please input a valid word',
        maxLines: 1,
      ),
    );
  }

  Widget _buildCreateWordWordSound() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SimpleAACTextField(
        labelText: 'Phonetic Override',
        textController: _wordSoundController,
        validatorMessage: 'Please input a valid word sound.',
        maxLines: 1,
      ),
    );
  }

  Widget _buildExtraRelatedWords(Word? word) {
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
            TextButton.icon(
              onPressed: () async {
                final current =
                    _wordViewModel.wordStream.valueOrNull?.extraRelatedWordIds ?? [];
                final result =
                    await WordPickerView.show(context, existingWordIds: current);
                if (result != null) _wordViewModel.setExtraRelatedWords(result);
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add prediction'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomButtonBar({
    required bool isLoading,
    required ManageWordViewArguments args,
  }) {
    final isEditing = args.word != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomButtonHolder(
          hasShadow: true,
          child: Row(
            children: [
              Expanded(
                child: RoundedButton(
                  label: 'Cancel',
                  isFilled: false,
                  onPressed: () {
                    if (isEditing) {
                      Navigator.of(context).popUntil(
                        (route) => route.settings.name == AppShell.routeName,
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: isLoading
                    ? const RoundedButton(label: 'Save', onPressed: null)
                    : StreamBuilder<bool>(
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
                                      Navigator.of(context).popUntil(
                                        (route) =>
                                            route.settings.name == AppShell.routeName,
                                      );
                                    } else {
                                      Navigator.of(context)
                                          .pop(_wordViewModel.wordStream.valueOrNull);
                                    }
                                  }
                                : null,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
