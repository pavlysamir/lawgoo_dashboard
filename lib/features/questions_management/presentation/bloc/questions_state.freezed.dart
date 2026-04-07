// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'questions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionsState {

 bool get isLoading; List<Question> get questions; List<LawEntity> get laws; List<LawMaterialEntity> get materials; String? get selectedLawId; String? get selectedMaterialId; int get selectedLevel; Failure? get failure; bool get isAddingQuestion; bool get addQuestionSuccess; String get searchQuery;
/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionsStateCopyWith<QuestionsState> get copyWith => _$QuestionsStateCopyWithImpl<QuestionsState>(this as QuestionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.questions, questions)&&const DeepCollectionEquality().equals(other.laws, laws)&&const DeepCollectionEquality().equals(other.materials, materials)&&(identical(other.selectedLawId, selectedLawId) || other.selectedLawId == selectedLawId)&&(identical(other.selectedMaterialId, selectedMaterialId) || other.selectedMaterialId == selectedMaterialId)&&(identical(other.selectedLevel, selectedLevel) || other.selectedLevel == selectedLevel)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isAddingQuestion, isAddingQuestion) || other.isAddingQuestion == isAddingQuestion)&&(identical(other.addQuestionSuccess, addQuestionSuccess) || other.addQuestionSuccess == addQuestionSuccess)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(questions),const DeepCollectionEquality().hash(laws),const DeepCollectionEquality().hash(materials),selectedLawId,selectedMaterialId,selectedLevel,failure,isAddingQuestion,addQuestionSuccess,searchQuery);

@override
String toString() {
  return 'QuestionsState(isLoading: $isLoading, questions: $questions, laws: $laws, materials: $materials, selectedLawId: $selectedLawId, selectedMaterialId: $selectedMaterialId, selectedLevel: $selectedLevel, failure: $failure, isAddingQuestion: $isAddingQuestion, addQuestionSuccess: $addQuestionSuccess, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $QuestionsStateCopyWith<$Res>  {
  factory $QuestionsStateCopyWith(QuestionsState value, $Res Function(QuestionsState) _then) = _$QuestionsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Question> questions, List<LawEntity> laws, List<LawMaterialEntity> materials, String? selectedLawId, String? selectedMaterialId, int selectedLevel, Failure? failure, bool isAddingQuestion, bool addQuestionSuccess, String searchQuery
});




}
/// @nodoc
class _$QuestionsStateCopyWithImpl<$Res>
    implements $QuestionsStateCopyWith<$Res> {
  _$QuestionsStateCopyWithImpl(this._self, this._then);

  final QuestionsState _self;
  final $Res Function(QuestionsState) _then;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? questions = null,Object? laws = null,Object? materials = null,Object? selectedLawId = freezed,Object? selectedMaterialId = freezed,Object? selectedLevel = null,Object? failure = freezed,Object? isAddingQuestion = null,Object? addQuestionSuccess = null,Object? searchQuery = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,laws: null == laws ? _self.laws : laws // ignore: cast_nullable_to_non_nullable
as List<LawEntity>,materials: null == materials ? _self.materials : materials // ignore: cast_nullable_to_non_nullable
as List<LawMaterialEntity>,selectedLawId: freezed == selectedLawId ? _self.selectedLawId : selectedLawId // ignore: cast_nullable_to_non_nullable
as String?,selectedMaterialId: freezed == selectedMaterialId ? _self.selectedMaterialId : selectedMaterialId // ignore: cast_nullable_to_non_nullable
as String?,selectedLevel: null == selectedLevel ? _self.selectedLevel : selectedLevel // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isAddingQuestion: null == isAddingQuestion ? _self.isAddingQuestion : isAddingQuestion // ignore: cast_nullable_to_non_nullable
as bool,addQuestionSuccess: null == addQuestionSuccess ? _self.addQuestionSuccess : addQuestionSuccess // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionsState].
extension QuestionsStatePatterns on QuestionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionsState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionsState():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionsState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Question> questions,  List<LawEntity> laws,  List<LawMaterialEntity> materials,  String? selectedLawId,  String? selectedMaterialId,  int selectedLevel,  Failure? failure,  bool isAddingQuestion,  bool addQuestionSuccess,  String searchQuery)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
return $default(_that.isLoading,_that.questions,_that.laws,_that.materials,_that.selectedLawId,_that.selectedMaterialId,_that.selectedLevel,_that.failure,_that.isAddingQuestion,_that.addQuestionSuccess,_that.searchQuery);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Question> questions,  List<LawEntity> laws,  List<LawMaterialEntity> materials,  String? selectedLawId,  String? selectedMaterialId,  int selectedLevel,  Failure? failure,  bool isAddingQuestion,  bool addQuestionSuccess,  String searchQuery)  $default,) {final _that = this;
switch (_that) {
case _QuestionsState():
return $default(_that.isLoading,_that.questions,_that.laws,_that.materials,_that.selectedLawId,_that.selectedMaterialId,_that.selectedLevel,_that.failure,_that.isAddingQuestion,_that.addQuestionSuccess,_that.searchQuery);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Question> questions,  List<LawEntity> laws,  List<LawMaterialEntity> materials,  String? selectedLawId,  String? selectedMaterialId,  int selectedLevel,  Failure? failure,  bool isAddingQuestion,  bool addQuestionSuccess,  String searchQuery)?  $default,) {final _that = this;
switch (_that) {
case _QuestionsState() when $default != null:
return $default(_that.isLoading,_that.questions,_that.laws,_that.materials,_that.selectedLawId,_that.selectedMaterialId,_that.selectedLevel,_that.failure,_that.isAddingQuestion,_that.addQuestionSuccess,_that.searchQuery);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionsState extends QuestionsState {
  const _QuestionsState({this.isLoading = false, final  List<Question> questions = const [], final  List<LawEntity> laws = const [], final  List<LawMaterialEntity> materials = const [], this.selectedLawId, this.selectedMaterialId, this.selectedLevel = 1, this.failure, this.isAddingQuestion = false, this.addQuestionSuccess = false, this.searchQuery = ''}): _questions = questions,_laws = laws,_materials = materials,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<Question> _questions;
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  List<LawEntity> _laws;
@override@JsonKey() List<LawEntity> get laws {
  if (_laws is EqualUnmodifiableListView) return _laws;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_laws);
}

 final  List<LawMaterialEntity> _materials;
@override@JsonKey() List<LawMaterialEntity> get materials {
  if (_materials is EqualUnmodifiableListView) return _materials;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_materials);
}

@override final  String? selectedLawId;
@override final  String? selectedMaterialId;
@override@JsonKey() final  int selectedLevel;
@override final  Failure? failure;
@override@JsonKey() final  bool isAddingQuestion;
@override@JsonKey() final  bool addQuestionSuccess;
@override@JsonKey() final  String searchQuery;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionsStateCopyWith<_QuestionsState> get copyWith => __$QuestionsStateCopyWithImpl<_QuestionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._questions, _questions)&&const DeepCollectionEquality().equals(other._laws, _laws)&&const DeepCollectionEquality().equals(other._materials, _materials)&&(identical(other.selectedLawId, selectedLawId) || other.selectedLawId == selectedLawId)&&(identical(other.selectedMaterialId, selectedMaterialId) || other.selectedMaterialId == selectedMaterialId)&&(identical(other.selectedLevel, selectedLevel) || other.selectedLevel == selectedLevel)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isAddingQuestion, isAddingQuestion) || other.isAddingQuestion == isAddingQuestion)&&(identical(other.addQuestionSuccess, addQuestionSuccess) || other.addQuestionSuccess == addQuestionSuccess)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_questions),const DeepCollectionEquality().hash(_laws),const DeepCollectionEquality().hash(_materials),selectedLawId,selectedMaterialId,selectedLevel,failure,isAddingQuestion,addQuestionSuccess,searchQuery);

@override
String toString() {
  return 'QuestionsState(isLoading: $isLoading, questions: $questions, laws: $laws, materials: $materials, selectedLawId: $selectedLawId, selectedMaterialId: $selectedMaterialId, selectedLevel: $selectedLevel, failure: $failure, isAddingQuestion: $isAddingQuestion, addQuestionSuccess: $addQuestionSuccess, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class _$QuestionsStateCopyWith<$Res> implements $QuestionsStateCopyWith<$Res> {
  factory _$QuestionsStateCopyWith(_QuestionsState value, $Res Function(_QuestionsState) _then) = __$QuestionsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Question> questions, List<LawEntity> laws, List<LawMaterialEntity> materials, String? selectedLawId, String? selectedMaterialId, int selectedLevel, Failure? failure, bool isAddingQuestion, bool addQuestionSuccess, String searchQuery
});




}
/// @nodoc
class __$QuestionsStateCopyWithImpl<$Res>
    implements _$QuestionsStateCopyWith<$Res> {
  __$QuestionsStateCopyWithImpl(this._self, this._then);

  final _QuestionsState _self;
  final $Res Function(_QuestionsState) _then;

/// Create a copy of QuestionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? questions = null,Object? laws = null,Object? materials = null,Object? selectedLawId = freezed,Object? selectedMaterialId = freezed,Object? selectedLevel = null,Object? failure = freezed,Object? isAddingQuestion = null,Object? addQuestionSuccess = null,Object? searchQuery = null,}) {
  return _then(_QuestionsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,laws: null == laws ? _self._laws : laws // ignore: cast_nullable_to_non_nullable
as List<LawEntity>,materials: null == materials ? _self._materials : materials // ignore: cast_nullable_to_non_nullable
as List<LawMaterialEntity>,selectedLawId: freezed == selectedLawId ? _self.selectedLawId : selectedLawId // ignore: cast_nullable_to_non_nullable
as String?,selectedMaterialId: freezed == selectedMaterialId ? _self.selectedMaterialId : selectedMaterialId // ignore: cast_nullable_to_non_nullable
as String?,selectedLevel: null == selectedLevel ? _self.selectedLevel : selectedLevel // ignore: cast_nullable_to_non_nullable
as int,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isAddingQuestion: null == isAddingQuestion ? _self.isAddingQuestion : isAddingQuestion // ignore: cast_nullable_to_non_nullable
as bool,addQuestionSuccess: null == addQuestionSuccess ? _self.addQuestionSuccess : addQuestionSuccess // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
