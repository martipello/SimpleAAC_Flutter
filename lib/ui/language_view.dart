import 'package:flutter/material.dart';

import '../api/models/language.dart';
import '../dependency_injection_container.dart';
import '../view_models/language_view_model.dart';

class LanguageView extends StatefulWidget {
  static const String routeName = '/theme';

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  final languageViewModel = getIt.get<LanguageViewModel>();

  @override
  void initState() {
    super.initState();
    languageViewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    languageViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a language'),
      ),
      body: StreamBuilder<Language?>(
        stream: languageViewModel.currentLanguage,
        builder: (context, snapshot) {
          final currentLanguage = snapshot.data;
          return Text(currentLanguage?.displayName ?? '');
        },
      ),
    );
  }
}
