import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../laws/domain/entities/law_entity.dart';

part 'questions_management_state.freezed.dart';

@freezed
class QuestionsManagementState with _$QuestionsManagementState {
  const factory QuestionsManagementState.initial() = _Initial;
  const factory QuestionsManagementState.loading() = _Loading;
  const factory QuestionsManagementState.success({
    required List<LawEntity> laws,
    required int totalLaws,
    required int activeLaws,
    @Default(false) bool isPaginating,
    @Default(false) bool isTogglingActive,
    Failure? paginationFailure,
    Failure? toggleActiveFailure,
  }) = _Success;
  const factory QuestionsManagementState.error(Failure failure) = _Error;
}
