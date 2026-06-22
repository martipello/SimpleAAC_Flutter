import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_usage.freezed.dart';
part 'word_usage.g.dart';

/// Per-user usage record stored in Firestore.
/// Firestore path: users/{uid}/wordUsage/{wordId}
@freezed
sealed class WordUsage with _$WordUsage {
  const factory WordUsage({
    required String wordId,
    @Default(0) int count,
    DateTime? lastUsed,
  }) = _WordUsage;

  factory WordUsage.fromJson(Map<String, dynamic> json) =>
      _$WordUsageFromJson(json);
}
