import 'dart:convert';
import 'dart:io';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:path_provider/path_provider.dart';

import '../api/models/word.dart';
import '../utils/constants.dart';

enum AiPredictionProvider { gemini, openai }

class AiPredictionService {
  AiPredictionService(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  // ── Gemini key ──────────────────────────────────────────────────────────────

  Future<String?> getGeminiKey() =>
      _secureStorage.read(key: Constants.GEMINI_API_KEY);

  Future<bool> hasGeminiKey() async =>
      ((await getGeminiKey())?.isNotEmpty) == true;

  Future<void> setGeminiKey(String key) =>
      _secureStorage.write(key: Constants.GEMINI_API_KEY, value: key);

  Future<void> clearGeminiKey() =>
      _secureStorage.delete(key: Constants.GEMINI_API_KEY);

  // ── OpenAI key (shared with TTS) ────────────────────────────────────────────

  Future<String?> getOpenAiKey() =>
      _secureStorage.read(key: Constants.OPENAI_API_KEY);

  Future<bool> hasOpenAiKey() async =>
      ((await getOpenAiKey())?.isNotEmpty) == true;

  // ── Image generation ────────────────────────────────────────────────────────

  /// Generates an image for [prompt] using DALL-E 3 (OpenAI key required).
  /// Returns a local file path on success, null on failure.
  Future<String?> generateImage(String prompt) async {
    final key = await getOpenAiKey();
    if (key == null || key.isEmpty) return null;

    try {
      OpenAI.apiKey = key;
      final response = await OpenAI.instance.image.create(
        prompt: 'AAC communication symbol for: $prompt. '
            'Simple, clear, flat illustration style, suitable for children, white background.',
        model: 'dall-e-3',
        n: 1,
        size: OpenAIImageSize.size1024,
        responseFormat: OpenAIImageResponseFormat.b64Json,
      );
      final b64 = response.data.first.b64Json;
      if (b64 == null) return null;
      final bytes = base64Decode(b64);
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/ai_image_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      print('AI image generation error: $e');
      return null;
    }
  }

  // ── Predictions ─────────────────────────────────────────────────────────────

  Future<List<Word>> getPredictions(
    List<Word> sentence,
    List<Word> vocabulary,
    AiPredictionProvider provider,
  ) async {
    if (sentence.isEmpty) return [];
    return switch (provider) {
      AiPredictionProvider.gemini => _predictWithGemini(sentence, vocabulary),
      AiPredictionProvider.openai => _predictWithOpenAi(sentence, vocabulary),
    };
  }

  Future<List<Word>> _predictWithGemini(
      List<Word> sentence, List<Word> vocabulary) async {
    final key = await getGeminiKey();
    if (key == null || key.isEmpty) return [];

    try {
      final model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: key,
        generationConfig: GenerationConfig(maxOutputTokens: 64),
      );
      final response = await model.generateContent(
        [Content.text(_buildGeminiPrompt(sentence, vocabulary))],
      );
      return _parseResponse(response.text?.trim() ?? '', vocabulary);
    } catch (e) {
      print('AI prediction (Gemini) error: $e');
      return [];
    }
  }

  Future<List<Word>> _predictWithOpenAi(
      List<Word> sentence, List<Word> vocabulary) async {
    final key = await getOpenAiKey();
    if (key == null || key.isEmpty) return [];

    try {
      OpenAI.apiKey = key;
      final vocabTexts = vocabulary.map((w) => w.text).take(300).join(', ');
      final wordList = sentence.map((w) => '"${w.text}"').join(', ');
      final response = await OpenAI.instance.chat.create(
        model: 'gpt-4o-mini',
        messages: [
          // System message establishes the role unambiguously
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                'You are an AAC (Augmentative and Alternative Communication) next-word predictor. '
                'A user builds a sentence by tapping words one at a time, left to right. '
                'You are given the words tapped SO FAR and a word bank. '
                'You must return up to 5 words from the word bank that the user should tap NEXT — '
                'i.e. words that would follow after ALL the words already tapped. '
                'Never return words that belong before the existing words. '
                'Return ONLY a raw JSON array with no markdown, e.g. ["water","more","please"].',
              ),
            ],
            role: OpenAIChatMessageRole.system,
          ),
          OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                'Words tapped so far: [$wordList]\n'
                'Word bank: $vocabTexts\n'
                'What word comes next?',
              ),
            ],
            role: OpenAIChatMessageRole.user,
          ),
        ],
        maxTokens: 64,
      );
      final text =
          response.choices.first.message.content?.first.text?.trim() ?? '';
      return _parseResponse(text, vocabulary);
    } catch (e) {
      print('AI prediction (OpenAI) error: $e');
      return [];
    }
  }

  String _buildGeminiPrompt(List<Word> sentence, List<Word> vocabulary) {
    final vocabTexts = vocabulary.map((w) => w.text).take(300).join(', ');
    final wordList = sentence.map((w) => '"${w.text}"').join(', ');
    return '''You predict the NEXT word an AAC user will tap. The user builds sentences left-to-right.

Examples of correct next-word prediction:
- Words so far: ["drink"] → next: ["water","milk","juice","more","please"]
- Words so far: ["I","want"] → next: ["to","more","food","drink","it"]
- Words so far: ["go","to","the"] → next: ["park","school","shop","beach","pool"]

Now predict for:
Words so far: [$wordList]
Word bank (only use words from this list): $vocabTexts

Output ONLY a raw JSON array of up to 5 words that come AFTER [$wordList], no markdown:''';
  }

  List<Word> _parseResponse(String text, List<Word> vocabulary) {
    print('AI prediction raw response: $text');
    final start = text.indexOf('[');
    final end = text.lastIndexOf(']');
    if (start == -1 || end == -1) {
      print('AI prediction: no JSON array found in response');
      return [];
    }
    try {
      final List<dynamic> suggested =
          jsonDecode(text.substring(start, end + 1));
      final suggestedSet =
          suggested.cast<String>().map((s) => s.toLowerCase().trim()).toSet();
      print('AI prediction suggested: $suggestedSet');
      return vocabulary
          .where((w) => suggestedSet.contains(w.text.toLowerCase().trim()))
          .take(5)
          .toList();
    } catch (e) {
      print('AI prediction parse error: $e');
      return [];
    }
  }
}
