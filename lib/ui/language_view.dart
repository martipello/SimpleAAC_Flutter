import 'package:flutter/material.dart';

import '../api/models/language.dart';
import '../api/models/word.dart';
import '../dependency_injection_container.dart';
import '../view_models/language_view_model.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/expansion_card.dart';
import 'shared_widgets/simple_aac_loading_widget.dart';
import 'shared_widgets/word_tile.dart';

class LanguageView extends StatefulWidget {
  static const String routeName = '/language';

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  final _languageViewModel = getIt.get<LanguageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(label: 'Choose a Language'),
      body: Builder(
        builder: (context) {
          final all = _languageViewModel.allLanguages();
          final current = _languageViewModel.getCurrentLanguage();
          if (current == null) return _buildLoading();
          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: all
                  .map((l) => _buildLanguageCard(l, current.id))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLanguageCard(Language language, String currentId) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ExpansionCard(
        title: language.displayName,
        expandedChildren: [
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: language.words
                    .take(10)
                    .map(_buildWordTile)
                    .toList(),
              ),
            ),
          ),
        ],
        onTap: () => _languageViewModel.setLanguage(language),
        borderSide: language.id == currentId
            ? const BorderSide(color: Colors.green, width: 2)
            : null,
      ),
    );
  }

  WordTile _buildWordTile(Word word) {
    return WordTile(word: word, key: UniqueKey(), heroTag: null);
  }

  Widget _buildLoading() => const Center(child: SimpleAACLoadingWidget());
}
