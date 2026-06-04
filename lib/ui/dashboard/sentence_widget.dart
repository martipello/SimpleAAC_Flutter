import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/models/extensions/word_extension.dart';
import '../../dependency_injection_container.dart';
import '../../view_models/selected_words_view_model.dart';
import '../shared_widgets/word_tile.dart';

class SentenceWidget extends StatefulWidget {
  const SentenceWidget({super.key});

  @override
  State<SentenceWidget> createState() => _SentenceWidgetState();
}

class _SentenceWidgetState extends State<SentenceWidget> {
  final _viewModel = getIt.get<SelectedWordsViewModel>();
  final _scrollController = ScrollController();

  /// GlobalKey per slot — lets Scrollable.ensureVisible locate each tile.
  final _tileKeys = <int, GlobalKey>{};

  late final Stream<(List<WordSlot>, Set<int>)> _combined;
  late final StreamSubscription<bool> _speakingSub;
  late final StreamSubscription<Set<int>> _highlightSub;
  late final StreamSubscription<List<WordSlot>> _wordsSub;

  @override
  void initState() {
    super.initState();

    _combined = CombineLatestStream.combine2(
      _viewModel.selectedWords,
      _viewModel.highlightedSlotIds,
      (slots, ids) => (slots, ids),
    );

    // Scroll to start when playback begins.
    _speakingSub = _viewModel.isSpeaking.distinct().listen((speaking) {
      if (speaking && _scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Keep the active word visible while speaking.
    _highlightSub = _viewModel.highlightedSlotIds.listen((ids) {
      if (ids.isEmpty) return;
      final key = _tileKeys[ids.first];
      final ctx = key?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: 0.0,
        );
      }
    });

    // Scroll to end when a new word is added (only when not speaking).
    _wordsSub = _viewModel.selectedWords.listen((_) {
      if (_viewModel.isSpeakingNow) return;
      const duration = Duration(milliseconds: 200);
      Future.delayed(duration).then((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: duration,
            curve: Curves.fastOutSlowIn,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _speakingSub.cancel();
    _highlightSub.cancel();
    _wordsSub.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(List<WordSlot>, Set<int>)>(
      stream: _combined,
      builder: (context, snapshot) {
        final slots = snapshot.data?.$1 ?? [];
        final highlightedIds = snapshot.data?.$2 ?? {};
        return SizedBox(
          height: 150,
          child: slots.isEmpty
              ? const Center(child: Text('EMPTY SENTENCE'))
              : _buildListView(slots, highlightedIds),
        );
      },
    );
  }

  Widget _buildListView(List<WordSlot> slots, Set<int> highlightedIds) {
    return ReorderableListView.builder(
      scrollDirection: Axis.horizontal,
      proxyDecorator: _proxyDecorator,
      itemCount: slots.length,
      onReorder: _viewModel.updatePositionSelectedWordList,
      padding: const EdgeInsets.fromLTRB(8, 8, 64, 8),
      scrollController: _scrollController,
      itemBuilder: (context, index) {
        final slot = slots[index];
        final tileKey = _tileKeys.putIfAbsent(slot.slotId, GlobalKey.new);
        return WordTile(
          key: tileKey,
          word: slot.word,
          heroTag: slot.word.getHeroTag('sentence-${slot.slotId}-'),
          isHighlighted: highlightedIds.contains(slot.slotId),
          closeButtonOnTap: (word) =>
              _viewModel.removeSelectedWord(word, slot.slotId),
          closeButtonOnLongPress: (_) => _viewModel.clearSelectedWordList(),
          hasReOrderButton: true,
          reorderIndex: index,
        );
      },
    );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final elevation = lerpDouble(
          0,
          8,
          Curves.easeInOut.transform(animation.value),
        )!;
        return Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.grey.withOpacity(0.1),
          child: child,
        );
      },
      child: child,
    );
  }
}
