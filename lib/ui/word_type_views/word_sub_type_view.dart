import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_aac/api/models/sentence.dart';
import 'package:simple_aac/api/models/word_base.dart';
import 'package:simple_aac/ui/shared_widgets/sentence_tile.dart';

import '../../../api/models/extensions/word_base_extension.dart';
import '../../../api/models/word.dart';
import '../../../api/models/word_sub_type.dart';
import '../../../dependency_injection_container.dart';
import '../../../view_models/selected_words_view_model.dart';
import '../../../view_models/words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class WordSubTypeView extends StatefulWidget {
  const WordSubTypeView({
    super.key,
    required this.wordSubType,
  });

  final WordSubType wordSubType;

  @override
  State<WordSubTypeView> createState() => _WordSubTypeViewState();
}

class _WordSubTypeViewState extends State<WordSubTypeView> with AutomaticKeepAliveClientMixin {
  final selectedWordsViewModel = getIt.get<SelectedWordsViewModel>();
  final wordsViewModel = getIt.get<WordsViewModel>();

  @override
  void initState() {
    super.initState();
    wordsViewModel.init(widget.wordSubType);
  }

  @override
  void dispose() {
    wordsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<BuiltList<WordBase>>(
      stream: wordsViewModel.wordsOfType,
      builder: (context, snapshot) {
        final words = snapshot.data ?? BuiltList();
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            // calculate screen width
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 0.86,
          ),
          itemCount: words.length,
          itemBuilder: (context, index) {
            final word = words[index];
            if (word is Word) {
              return WordTile(
                word: word,
                key: ValueKey(word.id),
                heroTag: word.getHeroTag(
                  '${word.type}-${word.subType}-${word.id}',
                ),
                wordTapCallBack: selectedWordsViewModel.addSelectedWord,
              );
            } else if (word is Sentence) {
              return SentenceTile(
                sentence: word,
                key: ValueKey(word.id),
                heroTag: word.getHeroTag(
                  '${word.type}-${word.subType}-${word.id}',
                ),
                sentenceTapCallBack: selectedWordsViewModel.addSelectedWord,
              );
            } else {
              return const SizedBox();
            }
          },
        );
        // return Padding(
        //   padding: const EdgeInsets.all(4.0),
          //TODO - add a sliver grid view builder
          // child: GridView.count(
          //   crossAxisCount: 4,
          //   // calculate screen width
          //   mainAxisSpacing: 4,
          //   crossAxisSpacing: 4,
          //   childAspectRatio: 0.86,
          //   children: words
          //       .map(
          //         (word) => WordTile(
          //           word: word,
          //           key: ValueKey(word.id),
          //           heroTag: word.getHeroTag(
          //             '${word.type}-${word.subType}-${word.id}',
          //           ),
          //           wordTapCallBack: selectedWordsViewModel.addSelectedWord,
          //         ),
          //       )
          //       .toList(),
          // ),
        // );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
