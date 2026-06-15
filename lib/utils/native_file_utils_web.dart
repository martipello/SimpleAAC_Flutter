import 'dart:typed_data';

/// On web, writing to the native filesystem is not possible.
/// [savePngBytesToTemp] returns null; callers should handle this
/// by encoding bytes as a data URL instead.
Future<String?> savePngBytesToTemp(Uint8List bytes) async => null;

/// OpenAI TTS file output is not supported on web; returns null so callers
/// can fall back to the platform TTS engine.
Future<String?> createOpenAiSpeechFile(
  String text,
  String voice,
  double speed,
) async =>
    null;
