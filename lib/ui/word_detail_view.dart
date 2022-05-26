import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../api/models/word.dart';
import '../extensions/iterable_extension.dart';
import 'create_word_view.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/simple_aac_dialog.dart';
import 'shared_widgets/simple_aac_table.dart';
import 'theme/base_theme.dart';
import 'theme/simple_aac_text.dart';

class WordDetailViewArguments {
  WordDetailViewArguments({
    required this.word,
  });

  final Word? word;
}

class WordDetailView extends StatefulWidget {
  static const String routeName = '/word-detail';

  @override
  State<WordDetailView> createState() => _WordDetailViewState();
}

class _WordDetailViewState extends State<WordDetailView> {
  WordDetailViewArguments get _wordDetailViewArguments => context.routeArguments as WordDetailViewArguments;

  @override
  Widget build(BuildContext context) {
    final _word = _wordDetailViewArguments.word;
    return Scaffold(
      appBar: SimpleAACAppBar(
        label: _word?.word ?? '',
        actions: _buildWordDetailActions(_word),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              _buildWordDetailImage(_word),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.play_arrow,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(
              16.0,
            ),
            child: SimpleAACTable(
              wordskiiTableRowInfoList: [
                SimpleAACTableRowInfo(
                  _word?.word ?? '',
                  Icons.title,
                  'Word : ',
                ),
                SimpleAACTableRowInfo(
                  _word?.sound ?? '',
                  Icons.volume_up,
                  'Speak : ',
                ),
                SimpleAACTableRowInfo(
                  _word?.subType?.name ?? '',
                  Icons.title,
                  'Description : ',
                ),
                SimpleAACTableRowInfo(
                  _word?.type?.name ?? '',
                  Icons.title,
                  'Type : ',
                ),
                SimpleAACTableRowInfo(
                  _word?.usageCount != null ? '${_word?.usageCount?.toString()} times' : '0 times',
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
                        color: colors(context).textOnForeground,
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: colors(context).textOnForeground,
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: colors(context).textOnForeground,
                      ),
                    ],
                  ),
                ),
                SimpleAACTableRowInfo(
                  '',
                  Icons.star_rounded,
                  'Predictions : ',
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: colors(context).textOnForeground,
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: colors(context).textOnForeground,
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: colors(context).textOnForeground,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordDetailImage(Word? _word) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Hero(
          tag: _word?.wordId ?? '',
          child: Image.asset(
            _word?.imageList.firstOrNull() ?? 'assets/images/sealstudioslogocenter.png',
            fit: BoxFit.cover,
            height: 250,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  List<Widget> _buildWordDetailActions(Word? _word) {
    return [
      IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {},
        icon: Icon(
          _word?.isFavourite == true ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        ),
      ),
      IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        onPressed: () {},
        icon: _buildMenuButton(_word),
      ),
    ];
  }

  Widget _buildMenuButton(Word? word) {
    return PopupMenuButton(
      onSelected: (result) async {
        if (result == 0) {
          Navigator.of(context).pushReplacementNamed(
            CreateWordView.routeName,
            arguments: CreateWordViewArguments(
              word: word,
            ),
          );
        }
        if (result == 1) {
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
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 0,
            child: _buildMenuItem(
              context,
              'Edit',
              Icons.edit,
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: _buildMenuItem(
              context,
              'Delete',
              Icons.delete,
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
          color: colors(context).textOnForeground,
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
