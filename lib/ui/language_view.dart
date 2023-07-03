import 'package:built_collection/built_collection.dart';
import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import 'package:simple_aac/api/models/word.dart';
import 'package:simple_aac/ui/shared_widgets/app_bar.dart';
import 'package:simple_aac/ui/shared_widgets/expansion_card.dart';
import 'package:simple_aac/ui/shared_widgets/simple_aac_loading_widget.dart';
import 'package:simple_aac/ui/shared_widgets/word_tile.dart';

import '../api/models/language.dart';
import '../dependency_injection_container.dart';
import '../view_models/language_view_model.dart';

class LanguageView extends StatefulWidget {
  static const String routeName = '/language';

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  final languageViewModel = getIt.get<LanguageViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(
        label: 'Choose a Language',
      ),
      body: ChangeNotifierBuilder(
        notifier: languageViewModel.languageService.sharedPreferencesService,
        builder: (context, _, __) {
          return FutureBuilder<BuiltList<Language>>(
            future: languageViewModel.allLanguages(),
            builder: (context, allLanguagesSnapshot) {
              return FutureBuilder<Language>(
                future: languageViewModel.getCurrentLanguage(),
                builder: (context, currentLanguagesSnapshot) {
                  final _currentLanguage = currentLanguagesSnapshot.data;
                  final _allLanguages = allLanguagesSnapshot.data ?? BuiltList<Language>();
                  if (_currentLanguage != null) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _allLanguages
                            .map(
                              (language) => _buildLanguageCard(
                                language,
                                _currentLanguage.id,
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }
                  return _buildLoading();
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLanguageCard(
    Language language,
    String currentLanguageId,
  ) {
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
                    .map(
                      (word) => _buildWordTile(word),
                    )
                    .toList(),
              ),
            ),
          )
        ],
        onTap: () {
          languageViewModel.setLanguage(language);
        },
        borderSide: language.id == currentLanguageId ? _buildSelectedBorderSide() : null,
      ),
    );
  }

  BorderSide _buildSelectedBorderSide() {
    return BorderSide(
      color: Colors.green,
      width: 2,
    );
  }

  WordTile _buildWordTile(Word word) {
    return WordTile(
      word: word,
      key: UniqueKey(),
      heroTag: null,
    );
  }

  Widget _buildLoading() => Center(
        child: SimpleAACLoadingWidget.circularProgressIndicator(),
      );
}
