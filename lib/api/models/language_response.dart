import 'package:freezed_annotation/freezed_annotation.dart';

import 'language.dart';

part 'language_response.freezed.dart';
part 'language_response.g.dart';

@freezed
sealed class LanguageResponse with _$LanguageResponse {
  const factory LanguageResponse({
    @Default([]) List<Language> languages,
  }) = _LanguageResponse;

  factory LanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguageResponseFromJson(json);
}
