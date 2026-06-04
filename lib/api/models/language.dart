import 'package:freezed_annotation/freezed_annotation.dart';

import 'word.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
sealed class Language with _$Language {
  const factory Language({
    required String id,
    required String displayName,
    @Default([]) List<Word> words,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}
