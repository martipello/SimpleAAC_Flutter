import 'dart:io';
import 'dart:typed_data';

import 'package:dart_openai/dart_openai.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> savePngBytesToTemp(Uint8List bytes) async {
  final dir = await getTemporaryDirectory();
  final file = File(
    '${dir.path}/draw_${DateTime.now().millisecondsSinceEpoch}.png',
  );
  await file.writeAsBytes(bytes);
  return file.path;
}

Future<String?> createOpenAiSpeechFile(
  String text,
  String voice,
  double speed,
) async {
  final tempDir = await getTemporaryDirectory();
  final file = await OpenAI.instance.audio.createSpeech(
    model: 'tts-1-hd',
    input: text,
    voice: voice,
    outputDirectory: tempDir,
    outputFileName: 'tts_${DateTime.now().millisecondsSinceEpoch}',
    speed: speed,
  );
  return file.path;
}

/// Not used on native — always returns null; use [createOpenAiSpeechFile].
Future<Uint8List?> createOpenAiSpeechBytes(
  String text,
  String voice,
  double speed,
  String apiKey,
) async =>
    null;
