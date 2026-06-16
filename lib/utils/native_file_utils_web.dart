import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data' as html;

/// On web, writing to the native filesystem is not possible.
/// [savePngBytesToTemp] returns null; callers should handle this
/// by encoding bytes as a data URL instead.
Future<String?> savePngBytesToTemp(Uint8List bytes) async => null;

/// Not used on web — returns null. Use [createOpenAiSpeechBytes] instead.
Future<String?> createOpenAiSpeechFile(
  String text,
  String voice,
  double speed,
) async =>
    null;

/// Calls the OpenAI TTS API directly from the browser and returns the
/// raw MP3 bytes, which can be played with audioplayers' [BytesSource].
Future<Uint8List?> createOpenAiSpeechBytes(
  String text,
  String voice,
  double speed,
  String apiKey,
) async {
  final completer = Completer<Uint8List?>();
  final xhr = html.HttpRequest();
  xhr.open('POST', 'https://api.openai.com/v1/audio/speech');
  xhr.setRequestHeader('Authorization', 'Bearer $apiKey');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.responseType = 'arraybuffer';
  xhr.onLoad.listen((_) {
    if (xhr.status == 200) {
      completer.complete(
        Uint8List.view(xhr.response as html.ByteBuffer),
      );
    } else {
      completer.complete(null);
    }
  });
  xhr.onError.listen((_) => completer.complete(null));
  xhr.send(json.encode({
    'model': 'tts-1-hd',
    'input': text,
    'voice': voice,
    'speed': speed,
  }));
  return completer.future;
}
