import 'package:flutter/material.dart';

import '../api/models/extensions/word_type_extension.dart';
import '../api/models/word.dart';
import '../dependency_injection_container.dart';
import '../extensions/build_context_extension.dart';
import '../extensions/iterable_extension.dart';
import '../view_models/create_word/create_word_view_model.dart';
import 'dashboard/predictions_widget.dart';
import 'pick_image_dialog.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/bottom_button_holder.dart';
import 'shared_widgets/rounded_button.dart';
import 'shared_widgets/simple_aac_text_field.dart';
import 'shared_widgets/simple_aac_tile.dart';
import 'shared_widgets/word_sub_type_picker.dart';
import 'shared_widgets/word_type_picker.dart';
import 'theme/base_theme.dart';

class CreateWordViewArguments {
  CreateWordViewArguments({
    required this.word,
  });

  final Word? word;
}

class CreateWordView extends StatefulWidget {
  static const String routeName = '/create-word';

  @override
  State<CreateWordView> createState() => _CreateWordViewState();
}

class _CreateWordViewState extends State<CreateWordView> {
  CreateWordViewArguments get _createWordViewArguments => context.routeArguments as CreateWordViewArguments;

  final _formKey = GlobalKey<FormState>();
  final _wordViewModel = getIt.get<CreateWordViewModel>();

  final _wordWordController = TextEditingController();
  final _wordSoundController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addTextListeners();
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
  Widget build(BuildContext context) {
    return StreamBuilder<Word?>(
      stream: _wordViewModel.wordStream,
      initialData: _createWordViewArguments.word,
      builder: (context, snapshot) {
        final _word = snapshot.data;
        return Scaffold(
          appBar: SimpleAACAppBar(
            label: _word?.word != null ? 'Edit ${_word?.word ?? ''}' : 'Create',
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
          _buildMediumMargin(),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
        child: Column(
          children: [
            SimpleAACTile(
              border: RoundedRectangleBorder(
                side: BorderSide(
                  color: _word?.type?.getColor(context) ?? colors(context).primary,
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
          _buildCreateWordWordLabel(_word),
          _buildCreateWordWordSound(_word),
          _buildMediumMargin(),
          _buildPredictions(_word),
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
          child: _buildSpeechButton(),
        ),
      ],
    );
  }

  Widget _buildSpeechButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.play_arrow),
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
        labelText: _word?.sound ?? 'Word Sound',
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
        labelText: _word?.word ?? 'Word Label',
        textController: _wordWordController,
        validatorMessage: 'Please input a valid word',
        maxLines: 1,
      ),
    );
  }

  Widget _buildCreateWordImage(
    Word? _word,
  ) {
    final imageUri = _word?.imageList.firstOrNull() ?? '';
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
              child: imageUri.isNotEmpty
                  ? Hero(
                      tag: _word?.wordId ?? '',
                      child: Image.asset(
                        imageUri,
                        fit: BoxFit.contain,
                      ),
                    )
                  : FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          color: colors(context).textOnForeground,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPredictions(
    Word? word,
  ) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: SizedBox(
            height: 32,
            child: word?.predictionList.isNotEmpty == true
                ? PredictionsWidget(
                    word: word,
                    onDelete: (word) {
                      if (word != null) {
                        _wordViewModel.removeWordPrediction(word);
                      }
                    })
                : null,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _buildAddPredictionButton(),
        ),
      ],
    );
  }

  Widget _buildAddPredictionButton() {
    return FloatingActionButton.small(
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
    BuildContext context,
  ) {
    return RoundedButton(
      label: 'Cancel',
      fillColor: colors(context).chrome,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
