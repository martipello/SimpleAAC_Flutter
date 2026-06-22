import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// Per-user profile stored in Firestore.
/// Firestore path: users/{uid}
@freezed
sealed class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String userId,
    @Default('l1') String currentLanguageId,
    @Default([]) List<String> favouriteWordIds,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
