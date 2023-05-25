import '../api/hive_client.dart';
import '../api/models/word.dart';

const kWordBox = 'words';

class WordService {
  WordService(this.hiveClient);

  final HiveClient hiveClient;

  Future<void> put(Word word) {
    return hiveClient.put<Word>(
      word.wordId,
      word,
    );
  }

  Future<void> delete(Word word) {
    return hiveClient.delete(word.wordId);
  }

  Future<Word?> get(String wordId) {
    return hiveClient.get<Word?>(wordId);
  }
}
