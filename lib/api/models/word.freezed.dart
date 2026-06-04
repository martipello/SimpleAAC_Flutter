// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Word {

 String get wordId;/// Text shown on the card.
 String get text;/// What the TTS engine speaks. If null, [text] is used directly.
/// Supports SSML/IPA for precise phonetic control.
 String? get phoneticOverride; WordType get type; WordSubType get subType;/// Asset paths (bundled) or local file paths (user-added images).
 List<String> get imagePaths;/// False for user-created words.
 bool get isCoreVocabulary; bool get isFavourite;/// Manually curated follow-up word IDs.
 List<String> get extraRelatedWordIds;/// Cached AI-suggested follow-up word IDs (offline predictions).
 List<String> get aiSuggestedFollowUps;/// Float32 vector for offline semantic search.
 List<double>? get localEmbedding; DateTime? get createdDate;
/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordCopyWith<Word> get copyWith => _$WordCopyWithImpl<Word>(this as Word, _$identity);

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Word&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.text, text) || other.text == text)&&(identical(other.phoneticOverride, phoneticOverride) || other.phoneticOverride == phoneticOverride)&&(identical(other.type, type) || other.type == type)&&(identical(other.subType, subType) || other.subType == subType)&&const DeepCollectionEquality().equals(other.imagePaths, imagePaths)&&(identical(other.isCoreVocabulary, isCoreVocabulary) || other.isCoreVocabulary == isCoreVocabulary)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&const DeepCollectionEquality().equals(other.extraRelatedWordIds, extraRelatedWordIds)&&const DeepCollectionEquality().equals(other.aiSuggestedFollowUps, aiSuggestedFollowUps)&&const DeepCollectionEquality().equals(other.localEmbedding, localEmbedding)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,text,phoneticOverride,type,subType,const DeepCollectionEquality().hash(imagePaths),isCoreVocabulary,isFavourite,const DeepCollectionEquality().hash(extraRelatedWordIds),const DeepCollectionEquality().hash(aiSuggestedFollowUps),const DeepCollectionEquality().hash(localEmbedding),createdDate);

@override
String toString() {
  return 'Word(wordId: $wordId, text: $text, phoneticOverride: $phoneticOverride, type: $type, subType: $subType, imagePaths: $imagePaths, isCoreVocabulary: $isCoreVocabulary, isFavourite: $isFavourite, extraRelatedWordIds: $extraRelatedWordIds, aiSuggestedFollowUps: $aiSuggestedFollowUps, localEmbedding: $localEmbedding, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $WordCopyWith<$Res>  {
  factory $WordCopyWith(Word value, $Res Function(Word) _then) = _$WordCopyWithImpl;
@useResult
$Res call({
 String wordId, String text, String? phoneticOverride, WordType type, WordSubType subType, List<String> imagePaths, bool isCoreVocabulary, bool isFavourite, List<String> extraRelatedWordIds, List<String> aiSuggestedFollowUps, List<double>? localEmbedding, DateTime? createdDate
});




}
/// @nodoc
class _$WordCopyWithImpl<$Res>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._self, this._then);

  final Word _self;
  final $Res Function(Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wordId = null,Object? text = null,Object? phoneticOverride = freezed,Object? type = null,Object? subType = null,Object? imagePaths = null,Object? isCoreVocabulary = null,Object? isFavourite = null,Object? extraRelatedWordIds = null,Object? aiSuggestedFollowUps = null,Object? localEmbedding = freezed,Object? createdDate = freezed,}) {
  return _then(_self.copyWith(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,phoneticOverride: freezed == phoneticOverride ? _self.phoneticOverride : phoneticOverride // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WordType,subType: null == subType ? _self.subType : subType // ignore: cast_nullable_to_non_nullable
as WordSubType,imagePaths: null == imagePaths ? _self.imagePaths : imagePaths // ignore: cast_nullable_to_non_nullable
as List<String>,isCoreVocabulary: null == isCoreVocabulary ? _self.isCoreVocabulary : isCoreVocabulary // ignore: cast_nullable_to_non_nullable
as bool,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,extraRelatedWordIds: null == extraRelatedWordIds ? _self.extraRelatedWordIds : extraRelatedWordIds // ignore: cast_nullable_to_non_nullable
as List<String>,aiSuggestedFollowUps: null == aiSuggestedFollowUps ? _self.aiSuggestedFollowUps : aiSuggestedFollowUps // ignore: cast_nullable_to_non_nullable
as List<String>,localEmbedding: freezed == localEmbedding ? _self.localEmbedding : localEmbedding // ignore: cast_nullable_to_non_nullable
as List<double>?,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Word].
extension WordPatterns on Word {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Word value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Word value)  $default,){
final _that = this;
switch (_that) {
case _Word():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Word value)?  $default,){
final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String wordId,  String text,  String? phoneticOverride,  WordType type,  WordSubType subType,  List<String> imagePaths,  bool isCoreVocabulary,  bool isFavourite,  List<String> extraRelatedWordIds,  List<String> aiSuggestedFollowUps,  List<double>? localEmbedding,  DateTime? createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.wordId,_that.text,_that.phoneticOverride,_that.type,_that.subType,_that.imagePaths,_that.isCoreVocabulary,_that.isFavourite,_that.extraRelatedWordIds,_that.aiSuggestedFollowUps,_that.localEmbedding,_that.createdDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String wordId,  String text,  String? phoneticOverride,  WordType type,  WordSubType subType,  List<String> imagePaths,  bool isCoreVocabulary,  bool isFavourite,  List<String> extraRelatedWordIds,  List<String> aiSuggestedFollowUps,  List<double>? localEmbedding,  DateTime? createdDate)  $default,) {final _that = this;
switch (_that) {
case _Word():
return $default(_that.wordId,_that.text,_that.phoneticOverride,_that.type,_that.subType,_that.imagePaths,_that.isCoreVocabulary,_that.isFavourite,_that.extraRelatedWordIds,_that.aiSuggestedFollowUps,_that.localEmbedding,_that.createdDate);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String wordId,  String text,  String? phoneticOverride,  WordType type,  WordSubType subType,  List<String> imagePaths,  bool isCoreVocabulary,  bool isFavourite,  List<String> extraRelatedWordIds,  List<String> aiSuggestedFollowUps,  List<double>? localEmbedding,  DateTime? createdDate)?  $default,) {final _that = this;
switch (_that) {
case _Word() when $default != null:
return $default(_that.wordId,_that.text,_that.phoneticOverride,_that.type,_that.subType,_that.imagePaths,_that.isCoreVocabulary,_that.isFavourite,_that.extraRelatedWordIds,_that.aiSuggestedFollowUps,_that.localEmbedding,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Word implements Word {
  const _Word({required this.wordId, required this.text, this.phoneticOverride, required this.type, required this.subType, required final  List<String> imagePaths, this.isCoreVocabulary = true, this.isFavourite = false, final  List<String> extraRelatedWordIds = const [], final  List<String> aiSuggestedFollowUps = const [], final  List<double>? localEmbedding, this.createdDate}): _imagePaths = imagePaths,_extraRelatedWordIds = extraRelatedWordIds,_aiSuggestedFollowUps = aiSuggestedFollowUps,_localEmbedding = localEmbedding;
  factory _Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

@override final  String wordId;
/// Text shown on the card.
@override final  String text;
/// What the TTS engine speaks. If null, [text] is used directly.
/// Supports SSML/IPA for precise phonetic control.
@override final  String? phoneticOverride;
@override final  WordType type;
@override final  WordSubType subType;
/// Asset paths (bundled) or local file paths (user-added images).
 final  List<String> _imagePaths;
/// Asset paths (bundled) or local file paths (user-added images).
@override List<String> get imagePaths {
  if (_imagePaths is EqualUnmodifiableListView) return _imagePaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imagePaths);
}

/// False for user-created words.
@override@JsonKey() final  bool isCoreVocabulary;
@override@JsonKey() final  bool isFavourite;
/// Manually curated follow-up word IDs.
 final  List<String> _extraRelatedWordIds;
/// Manually curated follow-up word IDs.
@override@JsonKey() List<String> get extraRelatedWordIds {
  if (_extraRelatedWordIds is EqualUnmodifiableListView) return _extraRelatedWordIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extraRelatedWordIds);
}

/// Cached AI-suggested follow-up word IDs (offline predictions).
 final  List<String> _aiSuggestedFollowUps;
/// Cached AI-suggested follow-up word IDs (offline predictions).
@override@JsonKey() List<String> get aiSuggestedFollowUps {
  if (_aiSuggestedFollowUps is EqualUnmodifiableListView) return _aiSuggestedFollowUps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aiSuggestedFollowUps);
}

/// Float32 vector for offline semantic search.
 final  List<double>? _localEmbedding;
/// Float32 vector for offline semantic search.
@override List<double>? get localEmbedding {
  final value = _localEmbedding;
  if (value == null) return null;
  if (_localEmbedding is EqualUnmodifiableListView) return _localEmbedding;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  DateTime? createdDate;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordCopyWith<_Word> get copyWith => __$WordCopyWithImpl<_Word>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Word&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.text, text) || other.text == text)&&(identical(other.phoneticOverride, phoneticOverride) || other.phoneticOverride == phoneticOverride)&&(identical(other.type, type) || other.type == type)&&(identical(other.subType, subType) || other.subType == subType)&&const DeepCollectionEquality().equals(other._imagePaths, _imagePaths)&&(identical(other.isCoreVocabulary, isCoreVocabulary) || other.isCoreVocabulary == isCoreVocabulary)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&const DeepCollectionEquality().equals(other._extraRelatedWordIds, _extraRelatedWordIds)&&const DeepCollectionEquality().equals(other._aiSuggestedFollowUps, _aiSuggestedFollowUps)&&const DeepCollectionEquality().equals(other._localEmbedding, _localEmbedding)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,text,phoneticOverride,type,subType,const DeepCollectionEquality().hash(_imagePaths),isCoreVocabulary,isFavourite,const DeepCollectionEquality().hash(_extraRelatedWordIds),const DeepCollectionEquality().hash(_aiSuggestedFollowUps),const DeepCollectionEquality().hash(_localEmbedding),createdDate);

@override
String toString() {
  return 'Word(wordId: $wordId, text: $text, phoneticOverride: $phoneticOverride, type: $type, subType: $subType, imagePaths: $imagePaths, isCoreVocabulary: $isCoreVocabulary, isFavourite: $isFavourite, extraRelatedWordIds: $extraRelatedWordIds, aiSuggestedFollowUps: $aiSuggestedFollowUps, localEmbedding: $localEmbedding, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$WordCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$WordCopyWith(_Word value, $Res Function(_Word) _then) = __$WordCopyWithImpl;
@override @useResult
$Res call({
 String wordId, String text, String? phoneticOverride, WordType type, WordSubType subType, List<String> imagePaths, bool isCoreVocabulary, bool isFavourite, List<String> extraRelatedWordIds, List<String> aiSuggestedFollowUps, List<double>? localEmbedding, DateTime? createdDate
});




}
/// @nodoc
class __$WordCopyWithImpl<$Res>
    implements _$WordCopyWith<$Res> {
  __$WordCopyWithImpl(this._self, this._then);

  final _Word _self;
  final $Res Function(_Word) _then;

/// Create a copy of Word
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wordId = null,Object? text = null,Object? phoneticOverride = freezed,Object? type = null,Object? subType = null,Object? imagePaths = null,Object? isCoreVocabulary = null,Object? isFavourite = null,Object? extraRelatedWordIds = null,Object? aiSuggestedFollowUps = null,Object? localEmbedding = freezed,Object? createdDate = freezed,}) {
  return _then(_Word(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,phoneticOverride: freezed == phoneticOverride ? _self.phoneticOverride : phoneticOverride // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WordType,subType: null == subType ? _self.subType : subType // ignore: cast_nullable_to_non_nullable
as WordSubType,imagePaths: null == imagePaths ? _self._imagePaths : imagePaths // ignore: cast_nullable_to_non_nullable
as List<String>,isCoreVocabulary: null == isCoreVocabulary ? _self.isCoreVocabulary : isCoreVocabulary // ignore: cast_nullable_to_non_nullable
as bool,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,extraRelatedWordIds: null == extraRelatedWordIds ? _self._extraRelatedWordIds : extraRelatedWordIds // ignore: cast_nullable_to_non_nullable
as List<String>,aiSuggestedFollowUps: null == aiSuggestedFollowUps ? _self._aiSuggestedFollowUps : aiSuggestedFollowUps // ignore: cast_nullable_to_non_nullable
as List<String>,localEmbedding: freezed == localEmbedding ? _self._localEmbedding : localEmbedding // ignore: cast_nullable_to_non_nullable
as List<double>?,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
