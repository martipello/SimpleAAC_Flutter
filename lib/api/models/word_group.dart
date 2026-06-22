import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_group.freezed.dart';
part 'word_group.g.dart';

/// A user-created phrase card — an ordered sequence of words saved as one tile.
/// Firestore path: users/{uid}/wordGroups/{groupId}
@freezed
sealed class WordGroup with _$WordGroup {
  const factory WordGroup({
    required String id,

    /// Display label on the group tile.
    required String title,

    /// Ordered word IDs that make up this phrase.
    required List<String> wordIds,

    /// Override what TTS speaks for the whole phrase.
    String? phoneticOverride,

    /// Custom image path, or auto-derived from the first word.
    String? imagePath,

    @Default(false) bool isFavourite,
    @Default(0) int usageCount,
    DateTime? createdDate,
  }) = _WordGroup;

  factory WordGroup.fromJson(Map<String, dynamic> json) =>
      _$WordGroupFromJson(json);
}
