import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/law_entity.dart';

part 'laws_state.freezed.dart';

@freezed
class LawsState with _$LawsState {
  const factory LawsState.initial() = _Initial;
  const factory LawsState.loading() = _Loading;
  const factory LawsState.success({
    required List<LawEntity> laws,
    required int totalLaws,
    required int activeLaws,
    @Default(false) bool isPaginating,
    @Default(false) bool showAddForm,
    @Default(false) bool isAddingLaw,
    Failure? paginationFailure,
    Failure? addLawFailure,
  }) = _Success;
  const factory LawsState.error(Failure failure) = _Error;
}
