import 'package:built_collection/built_collection.dart';
import 'package:change_notifier_builder/change_notifier_builder.dart';
import 'package:flutter/material.dart';
import '../api/models/word.dart';
import 'shared_widgets/app_bar.dart';
import 'shared_widgets/expansion_card.dart';
import 'shared_widgets/simple_aac_loading_widget.dart';
import 'shared_widgets/word_tile.dart';

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
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: SimpleAACAppBar(
        label: 'Choose a Language',
      ),
      body: ChangeNotifierBuilder(
        notifier: languageViewModel.languageService.sharedPreferencesService,
        builder: (final context, final _, final __) {
          return FutureBuilder<BuiltList<Language>>(
            future: languageViewModel.allLanguages(),
            builder: (final context, final allLanguagesSnapshot) {
              return FutureBuilder<Language>(
                future: languageViewModel.getCurrentLanguage(),
                builder: (final context, final currentLanguagesSnapshot) {
                  final _currentLanguage = currentLanguagesSnapshot.data;
                  final _allLanguages = allLanguagesSnapshot.data ?? BuiltList<Language>();
                  if (_currentLanguage != null) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _allLanguages
                            .map(
                              (final language) => _buildLanguageCard(
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
    final Language language,
    final String currentLanguageId,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
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
                      (final word) => _buildWordTile(word),
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

  WordTile _buildWordTile(final Word word) {
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
