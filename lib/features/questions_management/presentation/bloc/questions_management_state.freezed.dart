// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_management_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionsManagementState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionsManagementState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionsManagementState()';
}


}

/// @nodoc
class $QuestionsManagementStateCopyWith<$Res>  {
$QuestionsManagementStateCopyWith(QuestionsManagementState _, $Res Function(QuestionsManagementState) __);
}


/// Adds pattern-matching-related methods to [QuestionsManagementState].
extension QuestionsManagementStatePatterns on QuestionsManagementState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<LawEntity> laws,  int totalLaws,  int activeLaws,  bool isPaginating,  bool isTogglingActive,  Failure? paginationFailure,  Failure? toggleActiveFailure)?  success,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.laws,_that.totalLaws,_that.activeLaws,_that.isPaginating,_that.isTogglingActive,_that.paginationFailure,_that.toggleActiveFailure);case _Error() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<LawEntity> laws,  int totalLaws,  int activeLaws,  bool isPaginating,  bool isTogglingActive,  Failure? paginationFailure,  Failure? toggleActiveFailure)  success,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.laws,_that.totalLaws,_that.activeLaws,_that.isPaginating,_that.isTogglingActive,_that.paginationFailure,_that.toggleActiveFailure);case _Error():
return error(_that.failure);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<LawEntity> laws,  int totalLaws,  int activeLaws,  bool isPaginating,  bool isTogglingActive,  Failure? paginationFailure,  Failure? toggleActiveFailure)?  success,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.laws,_that.totalLaws,_that.activeLaws,_that.isPaginating,_that.isTogglingActive,_that.paginationFailure,_that.toggleActiveFailure);case _Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements QuestionsManagementState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionsManagementState.initial()';
}


}




/// @nodoc


class _Loading implements QuestionsManagementState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuestionsManagementState.loading()';
}


}




/// @nodoc


class _Success implements QuestionsManagementState {
  const _Success({required final  List<LawEntity> laws, required this.totalLaws, required this.activeLaws, this.isPaginating = false, this.isTogglingActive = false, this.paginationFailure, this.toggleActiveFailure}): _laws = laws;
  

 final  List<LawEntity> _laws;
 List<LawEntity> get laws {
  if (_laws is EqualUnmodifiableListView) return _laws;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_laws);
}

 final  int totalLaws;
 final  int activeLaws;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isTogglingActive;
 final  Failure? paginationFailure;
 final  Failure? toggleActiveFailure;

/// Create a copy of QuestionsManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._laws, _laws)&&(identical(other.totalLaws, totalLaws) || other.totalLaws == totalLaws)&&(identical(other.activeLaws, activeLaws) || other.activeLaws == activeLaws)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isTogglingActive, isTogglingActive) || other.isTogglingActive == isTogglingActive)&&(identical(other.paginationFailure, paginationFailure) || other.paginationFailure == paginationFailure)&&(identical(other.toggleActiveFailure, toggleActiveFailure) || other.toggleActiveFailure == toggleActiveFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_laws),totalLaws,activeLaws,isPaginating,isTogglingActive,paginationFailure,toggleActiveFailure);

@override
String toString() {
  return 'QuestionsManagementState.success(laws: $laws, totalLaws: $totalLaws, activeLaws: $activeLaws, isPaginating: $isPaginating, isTogglingActive: $isTogglingActive, paginationFailure: $paginationFailure, toggleActiveFailure: $toggleActiveFailure)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $QuestionsManagementStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<LawEntity> laws, int totalLaws, int activeLaws, bool isPaginating, bool isTogglingActive, Failure? paginationFailure, Failure? toggleActiveFailure
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of QuestionsManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? laws = null,Object? totalLaws = null,Object? activeLaws = null,Object? isPaginating = null,Object? isTogglingActive = null,Object? paginationFailure = freezed,Object? toggleActiveFailure = freezed,}) {
  return _then(_Success(
laws: null == laws ? _self._laws : laws // ignore: cast_nullable_to_non_nullable
as List<LawEntity>,totalLaws: null == totalLaws ? _self.totalLaws : totalLaws // ignore: cast_nullable_to_non_nullable
as int,activeLaws: null == activeLaws ? _self.activeLaws : activeLaws // ignore: cast_nullable_to_non_nullable
as int,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isTogglingActive: null == isTogglingActive ? _self.isTogglingActive : isTogglingActive // ignore: cast_nullable_to_non_nullable
as bool,paginationFailure: freezed == paginationFailure ? _self.paginationFailure : paginationFailure // ignore: cast_nullable_to_non_nullable
as Failure?,toggleActiveFailure: freezed == toggleActiveFailure ? _self.toggleActiveFailure : toggleActiveFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

/// @nodoc


class _Error implements QuestionsManagementState {
  const _Error(this.failure);
  

 final  Failure failure;

/// Create a copy of QuestionsManagementState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'QuestionsManagementState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $QuestionsManagementStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of QuestionsManagementState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Error(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
