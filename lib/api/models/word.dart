import 'package:freezed_annotation/freezed_annotation.dart';

import 'word_sub_type.dart';
import 'word_type.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
sealed class Word with _$Word {
  const factory Word({
    required String wordId,

    /// Text shown on the card.
    required String text,

    /// What the TTS engine speaks. If null, [text] is used directly.
    /// Supports SSML/IPA for precise phonetic control.
    String? phoneticOverride,

    required WordType type,
    required WordSubType subType,

    /// Asset paths (bundled) or local file paths (user-added images).
    required List<String> imagePaths,

    /// False for user-created words.
    @Default(true) bool isCoreVocabulary,

    @Default(false) bool isFavourite,

    /// Manually curated follow-up word IDs.
    @Default([]) List<String> extraRelatedWordIds,

    /// Cached AI-suggested follow-up word IDs (offline predictions).
    @Default([]) List<String> aiSuggestedFollowUps,

    /// Float32 vector for offline semantic search.
    List<double>? localEmbedding,

    DateTime? createdDate,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
