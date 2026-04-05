// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'law_materials_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LawMaterialsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LawMaterialsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LawMaterialsState()';
}


}

/// @nodoc
class $LawMaterialsStateCopyWith<$Res>  {
$LawMaterialsStateCopyWith(LawMaterialsState _, $Res Function(LawMaterialsState) __);
}


/// Adds pattern-matching-related methods to [LawMaterialsState].
extension LawMaterialsStatePatterns on LawMaterialsState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<LawMaterialEntity> materials,  int totalMaterials,  int currentPage,  int itemsPerPage,  bool isPaginating,  bool isAddingMaterial,  bool isDeletingMaterial,  bool isUpdatingMaterial,  String? searchQuery,  LawMaterialEntity? editingMaterial,  Failure? operationFailure)?  success,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.materials,_that.totalMaterials,_that.currentPage,_that.itemsPerPage,_that.isPaginating,_that.isAddingMaterial,_that.isDeletingMaterial,_that.isUpdatingMaterial,_that.searchQuery,_that.editingMaterial,_that.operationFailure);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<LawMaterialEntity> materials,  int totalMaterials,  int currentPage,  int itemsPerPage,  bool isPaginating,  bool isAddingMaterial,  bool isDeletingMaterial,  bool isUpdatingMaterial,  String? searchQuery,  LawMaterialEntity? editingMaterial,  Failure? operationFailure)  success,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.materials,_that.totalMaterials,_that.currentPage,_that.itemsPerPage,_that.isPaginating,_that.isAddingMaterial,_that.isDeletingMaterial,_that.isUpdatingMaterial,_that.searchQuery,_that.editingMaterial,_that.operationFailure);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<LawMaterialEntity> materials,  int totalMaterials,  int currentPage,  int itemsPerPage,  bool isPaginating,  bool isAddingMaterial,  bool isDeletingMaterial,  bool isUpdatingMaterial,  String? searchQuery,  LawMaterialEntity? editingMaterial,  Failure? operationFailure)?  success,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.materials,_that.totalMaterials,_that.currentPage,_that.itemsPerPage,_that.isPaginating,_that.isAddingMaterial,_that.isDeletingMaterial,_that.isUpdatingMaterial,_that.searchQuery,_that.editingMaterial,_that.operationFailure);case _Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LawMaterialsState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LawMaterialsState.initial()';
}


}




/// @nodoc


class _Loading implements LawMaterialsState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LawMaterialsState.loading()';
}


}




/// @nodoc


class _Success implements LawMaterialsState {
  const _Success({required final  List<LawMaterialEntity> materials, required this.totalMaterials, this.currentPage = 1, this.itemsPerPage = 4, this.isPaginating = false, this.isAddingMaterial = false, this.isDeletingMaterial = false, this.isUpdatingMaterial = false, this.searchQuery, this.editingMaterial, this.operationFailure}): _materials = materials;
  

 final  List<LawMaterialEntity> _materials;
 List<LawMaterialEntity> get materials {
  if (_materials is EqualUnmodifiableListView) return _materials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_materials);
}

 final  int totalMaterials;
@JsonKey() final  int currentPage;
@JsonKey() final  int itemsPerPage;
@JsonKey() final  bool isPaginating;
@JsonKey() final  bool isAddingMaterial;
@JsonKey() final  bool isDeletingMaterial;
@JsonKey() final  bool isUpdatingMaterial;
 final  String? searchQuery;
 final  LawMaterialEntity? editingMaterial;
 final  Failure? operationFailure;

/// Create a copy of LawMaterialsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._materials, _materials)&&(identical(other.totalMaterials, totalMaterials) || other.totalMaterials == totalMaterials)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage)&&(identical(other.isPaginating, isPaginating) || other.isPaginating == isPaginating)&&(identical(other.isAddingMaterial, isAddingMaterial) || other.isAddingMaterial == isAddingMaterial)&&(identical(other.isDeletingMaterial, isDeletingMaterial) || other.isDeletingMaterial == isDeletingMaterial)&&(identical(other.isUpdatingMaterial, isUpdatingMaterial) || other.isUpdatingMaterial == isUpdatingMaterial)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.editingMaterial, editingMaterial) || other.editingMaterial == editingMaterial)&&(identical(other.operationFailure, operationFailure) || other.operationFailure == operationFailure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_materials),totalMaterials,currentPage,itemsPerPage,isPaginating,isAddingMaterial,isDeletingMaterial,isUpdatingMaterial,searchQuery,editingMaterial,operationFailure);

@override
String toString() {
  return 'LawMaterialsState.success(materials: $materials, totalMaterials: $totalMaterials, currentPage: $currentPage, itemsPerPage: $itemsPerPage, isPaginating: $isPaginating, isAddingMaterial: $isAddingMaterial, isDeletingMaterial: $isDeletingMaterial, isUpdatingMaterial: $isUpdatingMaterial, searchQuery: $searchQuery, editingMaterial: $editingMaterial, operationFailure: $operationFailure)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $LawMaterialsStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<LawMaterialEntity> materials, int totalMaterials, int currentPage, int itemsPerPage, bool isPaginating, bool isAddingMaterial, bool isDeletingMaterial, bool isUpdatingMaterial, String? searchQuery, LawMaterialEntity? editingMaterial, Failure? operationFailure
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of LawMaterialsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? materials = null,Object? totalMaterials = null,Object? currentPage = null,Object? itemsPerPage = null,Object? isPaginating = null,Object? isAddingMaterial = null,Object? isDeletingMaterial = null,Object? isUpdatingMaterial = null,Object? searchQuery = freezed,Object? editingMaterial = freezed,Object? operationFailure = freezed,}) {
  return _then(_Success(
materials: null == materials ? _self._materials : materials // ignore: cast_nullable_to_non_nullable
as List<LawMaterialEntity>,totalMaterials: null == totalMaterials ? _self.totalMaterials : totalMaterials // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,isPaginating: null == isPaginating ? _self.isPaginating : isPaginating // ignore: cast_nullable_to_non_nullable
as bool,isAddingMaterial: null == isAddingMaterial ? _self.isAddingMaterial : isAddingMaterial // ignore: cast_nullable_to_non_nullable
as bool,isDeletingMaterial: null == isDeletingMaterial ? _self.isDeletingMaterial : isDeletingMaterial // ignore: cast_nullable_to_non_nullable
as bool,isUpdatingMaterial: null == isUpdatingMaterial ? _self.isUpdatingMaterial : isUpdatingMaterial // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,editingMaterial: freezed == editingMaterial ? _self.editingMaterial : editingMaterial // ignore: cast_nullable_to_non_nullable
as LawMaterialEntity?,operationFailure: freezed == operationFailure ? _self.operationFailure : operationFailure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

/// @nodoc


class _Error implements LawMaterialsState {
  const _Error(this.failure);
  

 final  Failure failure;

/// Create a copy of LawMaterialsState
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
  return 'LawMaterialsState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $LawMaterialsStateCopyWith<$Res> {
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

/// Create a copy of LawMaterialsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_Error(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
