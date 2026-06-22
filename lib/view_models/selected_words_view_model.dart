import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../api/models/word.dart';
import '../services/ai_prediction_service.dart' show AiPredictionService, AiPredictionProvider;
import '../services/shared_preferences_service.dart';
import '../services/tts_service.dart';
import '../services/word_service.dart';
import '../services/word_usage_service.dart';
import '../ui/dashboard/sentence_builder.dart';

/// A word occupying one slot in the sentence.
/// [slotId] is unique per insertion, allowing the same word to appear multiple
/// times with distinct identities.
typedef WordSlot = ({int slotId, Word word});

class SelectedWordsViewModel {
  SelectedWordsViewModel(
    this._wordService,
    this._usageService,
    this._ttsService,
    this._aiService,
    this._prefs,
  ) {
    _aiSub = selectedWords
        .debounceTime(const Duration(milliseconds: 900))
        .listen(_updateAiPredictions);
  }

  final WordService _wordService;
  final WordUsageService _usageService;
  final TtsService _ttsService;
  final AiPredictionService _aiService;
  final SharedPreferencesService _prefs;

  int _nextSlotId = 0;

  StreamSubscription<List<WordSlot>>? _aiSub;

  final selectedWords = BehaviorSubject<List<WordSlot>>.seeded([]);
  final relatedWords = BehaviorSubject<List<Word>>.seeded([]);
  // null = loading, [] = done with no results, [...] = predictions ready
  final aiPredictions = BehaviorSubject<List<Word>?>.seeded(null);

  Stream<Set<int>> get highlightedSlotIds => _ttsService.highlightedSlotIds;
  Stream<bool> get isSpeaking => _ttsService.isSpeaking;
  bool get isSpeakingNow => _ttsService.isSpeakingNow;

  void dispose() {
    _aiSub?.cancel();
    selectedWords.close();
    relatedWords.close();
    aiPredictions.close();
  }

  Future<void> addSelectedWord(Word word) async {
    final slot = (slotId: _nextSlotId++, word: word);
    final updatedSlots = [...selectedWords.value, slot];
    selectedWords.add(updatedSlots);
    // Fire-and-forget: increment usage count in Firestore.
    _usageService.increment(word.wordId);
    // Update related words using the full sentence for context-aware AI suggestions.
    if (_prefs.aiPredictionsEnabled) {
      final allWords = updatedSlots.map((s) => s.word).toList();
      final vocab = await _wordService.getAllWords();
      final provider = _prefs.aiPredictionProvider == 'openai'
          ? AiPredictionProvider.openai
          : AiPredictionProvider.gemini;
      final suggestions = await _aiService.getPredictions(allWords, vocab, provider);
      if (!relatedWords.isClosed) relatedWords.add(suggestions);
    } else {
      final related = await _wordService.getRelatedWords(word);
      relatedWords.add(related);
    }
  }

  void addAllWords(List<Word> words) {
    final newSlots =
        words.map((w) => (slotId: _nextSlotId++, word: w)).toList();
    selectedWords.add([...selectedWords.value, ...newSlots]);
  }

  void removeSelectedWord(Word word, int slotId) {
    selectedWords.add(
      selectedWords.value.where((s) => s.slotId != slotId).toList(),
    );
  }

  void setRelatedWords(List<Word> words) => relatedWords.add(words);

  Future<void> setRelatedWordsForWordIds(List<String> ids) async {
    final words = await _wordService.getWordsForIds(ids);
    relatedWords.add(words);
  }

  void updatePositionSelectedWordList(int oldIndex, int newIndex) {
    final slots = [...selectedWords.value];
    if (newIndex > oldIndex) newIndex--;
    final slot = slots.removeAt(oldIndex);
    slots.insert(newIndex, slot);
    selectedWords.add(slots);
  }

  void clearSelectedWordList() {
    _ttsService.stop();
    selectedWords.add([]);
  }

  /// Speaks the sentence, merging suffix words for natural TTS.
  /// If already speaking, stops playback instead.
  Future<void> toggleSpeak() async {
    if (_ttsService.isSpeakingNow) {
      await _ttsService.stop();
      return;
    }
    final slots = selectedWords.value;
    if (slots.isEmpty) return;
    final plan = SentenceBuilder.build(slots);
    await _ttsService.speak(plan);
  }

  Future<void> _updateAiPredictions(List<WordSlot> slots) async {
    if (!_prefs.aiPredictionsEnabled || slots.isEmpty) {
      aiPredictions.add(null);
      return;
    }
    aiPredictions.add(null); // signal loading
    print('AI predictions: fetching for sentence "${slots.map((s) => s.word.text).join(' ')}"');
    final words = slots.map((s) => s.word).toList();
    final vocab = await _wordService.getAllWords();
    print('AI predictions: vocab size = ${vocab.length}');
    final provider = _prefs.aiPredictionProvider == 'openai'
        ? AiPredictionProvider.openai
        : AiPredictionProvider.gemini;
    final predictions = await _aiService.getPredictions(words, vocab, provider);
    print('AI predictions: got ${predictions.length} results: ${predictions.map((w) => w.text)}');
    if (!aiPredictions.isClosed) aiPredictions.add(predictions);
  }
}
