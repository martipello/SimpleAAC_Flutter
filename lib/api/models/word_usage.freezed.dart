// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WordUsage {

 String get wordId; int get count; DateTime? get lastUsed;
/// Create a copy of WordUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WordUsageCopyWith<WordUsage> get copyWith => _$WordUsageCopyWithImpl<WordUsage>(this as WordUsage, _$identity);

  /// Serializes this WordUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WordUsage&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.count, count) || other.count == count)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,count,lastUsed);

@override
String toString() {
  return 'WordUsage(wordId: $wordId, count: $count, lastUsed: $lastUsed)';
}


}

/// @nodoc
abstract mixin class $WordUsageCopyWith<$Res>  {
  factory $WordUsageCopyWith(WordUsage value, $Res Function(WordUsage) _then) = _$WordUsageCopyWithImpl;
@useResult
$Res call({
 String wordId, int count, DateTime? lastUsed
});




}
/// @nodoc
class _$WordUsageCopyWithImpl<$Res>
    implements $WordUsageCopyWith<$Res> {
  _$WordUsageCopyWithImpl(this._self, this._then);

  final WordUsage _self;
  final $Res Function(WordUsage) _then;

/// Create a copy of WordUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wordId = null,Object? count = null,Object? lastUsed = freezed,}) {
  return _then(_self.copyWith(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WordUsage].
extension WordUsagePatterns on WordUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WordUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WordUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WordUsage value)  $default,){
final _that = this;
switch (_that) {
case _WordUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WordUsage value)?  $default,){
final _that = this;
switch (_that) {
case _WordUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String wordId,  int count,  DateTime? lastUsed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WordUsage() when $default != null:
return $default(_that.wordId,_that.count,_that.lastUsed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String wordId,  int count,  DateTime? lastUsed)  $default,) {final _that = this;
switch (_that) {
case _WordUsage():
return $default(_that.wordId,_that.count,_that.lastUsed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String wordId,  int count,  DateTime? lastUsed)?  $default,) {final _that = this;
switch (_that) {
case _WordUsage() when $default != null:
return $default(_that.wordId,_that.count,_that.lastUsed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WordUsage implements WordUsage {
  const _WordUsage({required this.wordId, this.count = 0, this.lastUsed});
  factory _WordUsage.fromJson(Map<String, dynamic> json) => _$WordUsageFromJson(json);

@override final  String wordId;
@override@JsonKey() final  int count;
@override final  DateTime? lastUsed;

/// Create a copy of WordUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WordUsageCopyWith<_WordUsage> get copyWith => __$WordUsageCopyWithImpl<_WordUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WordUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WordUsage&&(identical(other.wordId, wordId) || other.wordId == wordId)&&(identical(other.count, count) || other.count == count)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,wordId,count,lastUsed);

@override
String toString() {
  return 'WordUsage(wordId: $wordId, count: $count, lastUsed: $lastUsed)';
}


}

/// @nodoc
abstract mixin class _$WordUsageCopyWith<$Res> implements $WordUsageCopyWith<$Res> {
  factory _$WordUsageCopyWith(_WordUsage value, $Res Function(_WordUsage) _then) = __$WordUsageCopyWithImpl;
@override @useResult
$Res call({
 String wordId, int count, DateTime? lastUsed
});




}
/// @nodoc
class __$WordUsageCopyWithImpl<$Res>
    implements _$WordUsageCopyWith<$Res> {
  __$WordUsageCopyWithImpl(this._self, this._then);

  final _WordUsage _self;
  final $Res Function(_WordUsage) _then;

/// Create a copy of WordUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wordId = null,Object? count = null,Object? lastUsed = freezed,}) {
  return _then(_WordUsage(
wordId: null == wordId ? _self.wordId : wordId // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
