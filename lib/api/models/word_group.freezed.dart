// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordGroup {

 String get id;/// Display label on the group tile.
 String get title;/// Ordered word IDs that make up this phrase.
 List<String> get wordIds;/// Override what TTS speaks for the whole phrase.
 String? get phoneticOverride;/// Custom image path, or auto-derived from the first word.
 String? get imagePath; bool get isFavourite; int get usageCount; DateTime? get createdDate;
/// Create a copy of WordGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordGroupCopyWith<WordGroup> get copyWith => _$WordGroupCopyWithImpl<WordGroup>(this as WordGroup, _$identity);

  /// Serializes this WordGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.wordIds, wordIds)&&(identical(other.phoneticOverride, phoneticOverride) || other.phoneticOverride == phoneticOverride)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(wordIds),phoneticOverride,imagePath,isFavourite,usageCount,createdDate);

@override
String toString() {
  return 'WordGroup(id: $id, title: $title, wordIds: $wordIds, phoneticOverride: $phoneticOverride, imagePath: $imagePath, isFavourite: $isFavourite, usageCount: $usageCount, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $WordGroupCopyWith<$Res>  {
  factory $WordGroupCopyWith(WordGroup value, $Res Function(WordGroup) _then) = _$WordGroupCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<String> wordIds, String? phoneticOverride, String? imagePath, bool isFavourite, int usageCount, DateTime? createdDate
});




}
/// @nodoc
class _$WordGroupCopyWithImpl<$Res>
    implements $WordGroupCopyWith<$Res> {
  _$WordGroupCopyWithImpl(this._self, this._then);

  final WordGroup _self;
  final $Res Function(WordGroup) _then;

/// Create a copy of WordGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? wordIds = null,Object? phoneticOverride = freezed,Object? imagePath = freezed,Object? isFavourite = null,Object? usageCount = null,Object? createdDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,wordIds: null == wordIds ? _self.wordIds : wordIds // ignore: cast_nullable_to_non_nullable
as List<String>,phoneticOverride: freezed == phoneticOverride ? _self.phoneticOverride : phoneticOverride // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordGroup].
extension WordGroupPatterns on WordGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordGroup value)  $default,){
final _that = this;
switch (_that) {
case _WordGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordGroup value)?  $default,){
final _that = this;
switch (_that) {
case _WordGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<String> wordIds,  String? phoneticOverride,  String? imagePath,  bool isFavourite,  int usageCount,  DateTime? createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordGroup() when $default != null:
return $default(_that.id,_that.title,_that.wordIds,_that.phoneticOverride,_that.imagePath,_that.isFavourite,_that.usageCount,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<String> wordIds,  String? phoneticOverride,  String? imagePath,  bool isFavourite,  int usageCount,  DateTime? createdDate)  $default,) {final _that = this;
switch (_that) {
case _WordGroup():
return $default(_that.id,_that.title,_that.wordIds,_that.phoneticOverride,_that.imagePath,_that.isFavourite,_that.usageCount,_that.createdDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<String> wordIds,  String? phoneticOverride,  String? imagePath,  bool isFavourite,  int usageCount,  DateTime? createdDate)?  $default,) {final _that = this;
switch (_that) {
case _WordGroup() when $default != null:
return $default(_that.id,_that.title,_that.wordIds,_that.phoneticOverride,_that.imagePath,_that.isFavourite,_that.usageCount,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordGroup implements WordGroup {
  const _WordGroup({required this.id, required this.title, required final  List<String> wordIds, this.phoneticOverride, this.imagePath, this.isFavourite = false, this.usageCount = 0, this.createdDate}): _wordIds = wordIds;
  factory _WordGroup.fromJson(Map<String, dynamic> json) => _$WordGroupFromJson(json);

@override final  String id;
/// Display label on the group tile.
@override final  String title;
/// Ordered word IDs that make up this phrase.
 final  List<String> _wordIds;
/// Ordered word IDs that make up this phrase.
@override List<String> get wordIds {
  if (_wordIds is EqualUnmodifiableListView) return _wordIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_wordIds);
}

/// Override what TTS speaks for the whole phrase.
@override final  String? phoneticOverride;
/// Custom image path, or auto-derived from the first word.
@override final  String? imagePath;
@override@JsonKey() final  bool isFavourite;
@override@JsonKey() final  int usageCount;
@override final  DateTime? createdDate;

/// Create a copy of WordGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordGroupCopyWith<_WordGroup> get copyWith => __$WordGroupCopyWithImpl<_WordGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._wordIds, _wordIds)&&(identical(other.phoneticOverride, phoneticOverride) || other.phoneticOverride == phoneticOverride)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.isFavourite, isFavourite) || other.isFavourite == isFavourite)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_wordIds),phoneticOverride,imagePath,isFavourite,usageCount,createdDate);

@override
String toString() {
  return 'WordGroup(id: $id, title: $title, wordIds: $wordIds, phoneticOverride: $phoneticOverride, imagePath: $imagePath, isFavourite: $isFavourite, usageCount: $usageCount, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$WordGroupCopyWith<$Res> implements $WordGroupCopyWith<$Res> {
  factory _$WordGroupCopyWith(_WordGroup value, $Res Function(_WordGroup) _then) = __$WordGroupCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<String> wordIds, String? phoneticOverride, String? imagePath, bool isFavourite, int usageCount, DateTime? createdDate
});




}
/// @nodoc
class __$WordGroupCopyWithImpl<$Res>
    implements _$WordGroupCopyWith<$Res> {
  __$WordGroupCopyWithImpl(this._self, this._then);

  final _WordGroup _self;
  final $Res Function(_WordGroup) _then;

/// Create a copy of WordGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? wordIds = null,Object? phoneticOverride = freezed,Object? imagePath = freezed,Object? isFavourite = null,Object? usageCount = null,Object? createdDate = freezed,}) {
  return _then(_WordGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,wordIds: null == wordIds ? _self._wordIds : wordIds // ignore: cast_nullable_to_non_nullable
as List<String>,phoneticOverride: freezed == phoneticOverride ? _self.phoneticOverride : phoneticOverride // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,isFavourite: null == isFavourite ? _self.isFavourite : isFavourite // ignore: cast_nullable_to_non_nullable
as bool,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,createdDate: freezed == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
