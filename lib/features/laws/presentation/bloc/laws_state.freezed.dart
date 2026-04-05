// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laws_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LawsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LawsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LawsState()';
}


}

/// @nodoc
class $LawsStateCopyWith<$Res>  {
$LawsStateCopyWith(LawsState _, $Res Function(LawsState) __);
}


/// Adds pattern-matching-related methods to [LawsState].
extension LawsStatePatterns on LawsState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<LawEntity> laws,  int totalLaws,  int activeLaws,  bool isPaginating,  bool showAddForm,  bool isAddingLaw,  bool isDeletingLaw,  Failure? paginationFailure,  Failure? addLawFailure,  Failure? deleteLawFailure)?  success,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.laws,_that.totalLaws,_that.activeLaws,_that.isPaginating,_that.showAddForm,_that.isAddingLaw,_that.isDeletingLaw,_that.paginationFailure,_that.addLawFailure,_that.deleteLawFailure);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<LawEntity> laws,  int totalLaws,  int activeLaws,  bool isPaginating,  bool showAddForm,  bool isAddingLaw,  bool isDeletingLaw,  Failure? paginationFailure,  Failure? addLawFailure,  Failure? deleteLawFailure)  success,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.laws,_that.totalLaws,_that.activeLaws,_that.isPaginating,_that.showAddForm,_that.isAddingLaw,_that.isDeletingLaw,_that.paginationFailure,_that.addLawFailure,_that.deleteLawFailure);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<LawEntity> laws,  int totalLaws,  int activeLaws,  bool isPaginating,  bool showAddForm,  bool isAddingLaw,  bool isDeletingLaw,  Failure? paginationFailure,  Failure? addLawFailure,  Failure? deleteLawFailure)?  success,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.laws,_that.totalLaws,_that.activeLaws,_that.isPaginating,_that.showAddForm,_that.isAddingLaw,_that.isDeletingLaw,_that.paginationFailure,_that.addLawFailure,_that.deleteLawFailure);case _Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LawsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LawsState.initial()';
}


}




/// @nodoc


class _Loading implements LawsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LawsState.loading()';
}


}




/// @nodoc


class _Success implements LawsState {
  const _Success({required final  List<LawEntity> laws, required this.totalLaws, required this.activeLaws, this.isPaginating = false, this.showAddForm = false, this.isAddingLaw = false, this.isDeletingLaw = false, this.paginationFailure, this.addLawFailure, this.deleteLawFailure}): _laws = laws;
  

 final  List<LawEntity> _laws;
 List<LawEntity> get laws {
  if (_laws is EqualUnmodifiableListView) return _laws;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_laws);
}

 final  int totalLaws;
 final  int activeLaws;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool showAddForm;
@JsonKey() final  bool isAddingLaw;
@JsonKey() final  bool isDeletingLaw;
 final  Failure? paginationFailure;
 final  Failure? addLawFailure;
 final  Failure? deleteLawFailure;

/// Create a copy of LawsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._laws, _laws)&&(identical(other.totalLaws, totalLaws) || other.totalLaws == totalLaws)&&(identical(other.activeLaws, activeLaws) || other.activeLaws == activeLaws)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.showAddForm, showAddForm) || other.showAddForm == showAddForm)&&(identical(other.isAddingLaw, isAddingLaw) || other.isAddingLaw == isAddingLaw)&&(identical(other.isDeletingLaw, isDeletingLaw) || other.isDeletingLaw == isDeletingLaw)&&(identical(other.paginationFailure, paginationFailure) || other.paginationFailure == paginationFailure)&&(identical(other.addLawFailure, addLawFailure) || other.addLawFailure == addLawFailure)&&(identical(other.deleteLawFailure, deleteLawFailure) || other.deleteLawFailure == deleteLawFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_laws),totalLaws,activeLaws,isPaginating,showAddForm,isAddingLaw,isDeletingLaw,paginationFailure,addLawFailure,deleteLawFailure);

@override
String toString() {
  return 'LawsState.success(laws: $laws, totalLaws: $totalLaws, activeLaws: $activeLaws, isPaginating: $isPaginating, showAddForm: $showAddForm, isAddingLaw: $isAddingLaw, isDeletingLaw: $isDeletingLaw, paginationFailure: $paginationFailure, addLawFailure: $addLawFailure, deleteLawFailure: $deleteLawFailure)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $LawsStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<LawEntity> laws, int totalLaws, int activeLaws, bool isPaginating, bool showAddForm, bool isAddingLaw, bool isDeletingLaw, Failure? paginationFailure, Failure? addLawFailure, Failure? deleteLawFailure
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of LawsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? laws = null,Object? totalLaws = null,Object? activeLaws = null,Object? isPaginating = null,Object? showAddForm = null,Object? isAddingLaw = null,Object? isDeletingLaw = null,Object? paginationFailure = freezed,Object? addLawFailure = freezed,Object? deleteLawFailure = freezed,}) {
  return _then(_Success(
laws: null == laws ? _self._laws : laws // ignore: cast_nullable_to_non_nullable
as List<LawEntity>,totalLaws: null == totalLaws ? _self.totalLaws : totalLaws // ignore: cast_nullable_to_non_nullable
as int,activeLaws: null == activeLaws ? _self.activeLaws : activeLaws // ignore: cast_nullable_to_non_nullable
as int,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,showAddForm: null == showAddForm ? _self.showAddForm : showAddForm // ignore: cast_nullable_to_non_nullable
as bool,isAddingLaw: null == isAddingLaw ? _self.isAddingLaw : isAddingLaw // ignore: cast_nullable_to_non_nullable
as bool,isDeletingLaw: null == isDeletingLaw ? _self.isDeletingLaw : isDeletingLaw // ignore: cast_nullable_to_non_nullable
as bool,paginationFailure: freezed == paginationFailure ? _self.paginationFailure : paginationFailure // ignore: cast_nullable_to_non_nullable
as Failure?,addLawFailure: freezed == addLawFailure ? _self.addLawFailure : addLawFailure // ignore: cast_nullable_to_non_nullable
as Failure?,deleteLawFailure: freezed == deleteLawFailure ? _self.deleteLawFailure : deleteLawFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

/// @nodoc


class _Error implements LawsState {
  const _Error(this.failure);
  

 final  Failure failure;

/// Create a copy of LawsState
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
  return 'LawsState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $LawsStateCopyWith<$Res> {
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

/// Create a copy of LawsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Error(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
