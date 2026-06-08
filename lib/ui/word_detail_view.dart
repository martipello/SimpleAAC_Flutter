import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../api/models/word.dart';
import '../dependency_injection_container.dart';
import '../extensions/iterable_extension.dart';
import '../services/image_path_service.dart';
import '../services/tts_service.dart';
import '../view_models/words_view_model.dart';
import '../extensions/string_extension.dart';
import 'dashboard/app_shell.dart';
import 'dashboard/related_words_widget.dart';
import 'manage_word_view.dart';
import 'shared_widgets/simple_aac_dialog.dart';
import 'shared_widgets/simple_aac_table.dart';
import 'shared_widgets/word_image.dart';
import 'theme/simple_aac_text.dart';

class WordDetailViewArguments {
  WordDetailViewArguments({required this.word, this.heroTag});

  final Word word;
  final String? heroTag;
}

const kImageHeight = 350.0;

enum _DetailAction { edit, delete }

class WordDetailView extends StatefulWidget {
  static const String routeName = '/word-detail';

  @override
  State<WordDetailView> createState() => _WordDetailViewState();
}

class _WordDetailViewState extends State<WordDetailView> {
  final _wordsViewModel = getIt.get<WordsViewModel>();
  final _ttsService = getIt.get<TtsService>();

  WordDetailViewArguments get _args =>
      context.routeArguments as WordDetailViewArguments;

  late Word _word = _args.word;
  String? get _heroTag => _args.heroTag;

  Future<void> _toggleFavourite() async {
    final updated = await _wordsViewModel.toggleFavourite(_word);
    if (mounted) setState(() => _word = updated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.25),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(_word.text.toTitleCase()),
        actions: [
          PopupMenuButton<_DetailAction>(
            onSelected: (action) => _handleAction(action, _word),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: _DetailAction.edit,
                child: ListTile(
                  leading: Icon(Icons.edit_outlined),
                  title: Text('Edit'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              PopupMenuItem(
                value: _DetailAction.delete,
                child: ListTile(
                  leading: Icon(Icons.delete_outline, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                _buildWordDetailImage(_word),
                _buildSpeechActionButton(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Details',
                    style: SimpleAACText.subtitle3Style.copyWith(
                      color: context.themeColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SimpleAACTable(
                    wordskiiTableRowInfoList: [
                      SimpleAACTableRowInfo(
                        _word.text,
                        Icons.title,
                        'Word : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.phoneticOverride ?? _word.text,
                        Icons.volume_up,
                        'Speak : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.subType.name,
                        Icons.category,
                        'Category : ',
                      ),
                      SimpleAACTableRowInfo(
                        _word.type.name,
                        Icons.label,
                        'Type : ',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Related Words',
                    style: SimpleAACText.subtitle3Style.copyWith(
                      color: context.themeColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<List<Word>>(
                    future: _wordsViewModel.getWordsForIds(_word.extraRelatedWordIds),
                    builder: (context, snapshot) {
                      return RelatedWordsWidget(
                        onRelatedWordSelected: (_) {},
                        relatedWords: snapshot.data ?? [],
                        isExpanded: true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: _toggleFavourite,
        child: Icon(
          _word.isFavourite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        ),
      ),
    );
  }

  Future<void> _handleAction(_DetailAction action, Word word) async {
    switch (action) {
      case _DetailAction.edit:
        await Navigator.of(context).pushNamed(
          ManageWordView.routeName,
          arguments: ManageWordViewArguments(word: word, heroTag: _heroTag),
        );
      case _DetailAction.delete:
        final confirm = await SimpleAACDialog(
          title: 'Delete word',
          content: const Text('Are you sure you want to delete this word?'),
          dialogActions: [
            DialogAction(
              actionText: 'Cancel',
              color: Colors.green,
              actionVoidCallback: () => Navigator.of(context).pop(false),
            ),
            DialogAction(
              actionText: 'Delete',
              color: Colors.red,
              actionVoidCallback: () => Navigator.of(context).pop(true),
            ),
          ],
        ).show(context);
        if (confirm == true && mounted) Navigator.of(context).pop();
    }
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
            child: StreamBuilder<bool>(
              stream: _ttsService.isSpeaking,
              builder: (context, snapshot) {
                final speaking = snapshot.data ?? false;
                return FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    if (speaking) {
                      _ttsService.stop();
                    } else {
                      _ttsService.speakWord(
                        _word.phoneticOverride ?? _word.text,
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
          ),
        ),
      ),
    );
  }

  Widget _buildWordDetailImage(Word word) {
    final image = _buildImage(word);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: _heroTag != null
          ? Hero(
              tag: _heroTag!,
              transitionOnUserGestures: true,
              placeholderBuilder: (_, __, child) => child,
              child: image,
            )
          : image,
    );
  }

  Widget _buildImage(Word word) => SizedBox(
        height: kImageHeight,
        width: double.infinity,
        child: WordImage(
          imagePath: getIt<ImagePathService>().resolve(word),
          fit: BoxFit.cover,
        ),
      );

}
