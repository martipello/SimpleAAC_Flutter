// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LanguageResponse {

 List<Language> get languages;
/// Create a copy of LanguageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageResponseCopyWith<LanguageResponse> get copyWith => _$LanguageResponseCopyWithImpl<LanguageResponse>(this as LanguageResponse, _$identity);

  /// Serializes this LanguageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageResponse&&const DeepCollectionEquality().equals(other.languages, languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(languages));

@override
String toString() {
  return 'LanguageResponse(languages: $languages)';
}


}

/// @nodoc
abstract mixin class $LanguageResponseCopyWith<$Res>  {
  factory $LanguageResponseCopyWith(LanguageResponse value, $Res Function(LanguageResponse) _then) = _$LanguageResponseCopyWithImpl;
@useResult
$Res call({
 List<Language> languages
});




}
/// @nodoc
class _$LanguageResponseCopyWithImpl<$Res>
    implements $LanguageResponseCopyWith<$Res> {
  _$LanguageResponseCopyWithImpl(this._self, this._then);

  final LanguageResponse _self;
  final $Res Function(LanguageResponse) _then;

/// Create a copy of LanguageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languages = null,}) {
  return _then(_self.copyWith(
languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageResponse].
extension LanguageResponsePatterns on LanguageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageResponse value)  $default,){
final _that = this;
switch (_that) {
case _LanguageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Language> languages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageResponse() when $default != null:
return $default(_that.languages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Language> languages)  $default,) {final _that = this;
switch (_that) {
case _LanguageResponse():
return $default(_that.languages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Language> languages)?  $default,) {final _that = this;
switch (_that) {
case _LanguageResponse() when $default != null:
return $default(_that.languages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LanguageResponse implements LanguageResponse {
  const _LanguageResponse({final  List<Language> languages = const []}): _languages = languages;
  factory _LanguageResponse.fromJson(Map<String, dynamic> json) => _$LanguageResponseFromJson(json);

 final  List<Language> _languages;
@override@JsonKey() List<Language> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}


/// Create a copy of LanguageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageResponseCopyWith<_LanguageResponse> get copyWith => __$LanguageResponseCopyWithImpl<_LanguageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageResponse&&const DeepCollectionEquality().equals(other._languages, _languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_languages));

@override
String toString() {
  return 'LanguageResponse(languages: $languages)';
}


}

/// @nodoc
abstract mixin class _$LanguageResponseCopyWith<$Res> implements $LanguageResponseCopyWith<$Res> {
  factory _$LanguageResponseCopyWith(_LanguageResponse value, $Res Function(_LanguageResponse) _then) = __$LanguageResponseCopyWithImpl;
@override @useResult
$Res call({
 List<Language> languages
});




}
/// @nodoc
class __$LanguageResponseCopyWithImpl<$Res>
    implements _$LanguageResponseCopyWith<$Res> {
  __$LanguageResponseCopyWithImpl(this._self, this._then);

  final _LanguageResponse _self;
  final $Res Function(_LanguageResponse) _then;

/// Create a copy of LanguageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languages = null,}) {
  return _then(_LanguageResponse(
languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>,
  ));
}


}

// dart format on
