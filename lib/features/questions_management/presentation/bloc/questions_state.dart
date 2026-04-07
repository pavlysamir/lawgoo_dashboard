import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../../laws/domain/entities/law_entity.dart';
import '../../../laws/domain/entities/law_material_entity.dart';
import '../../domain/entities/question.dart';

part 'questions_state.freezed.dart';

@freezed
abstract class QuestionsState with _$QuestionsState {
  const QuestionsState._();
  const factory QuestionsState({
    @Default(false) bool isLoading,
    @Default([]) List<Question> questions,
    @Default([]) List<LawEntity> laws,
    @Default([]) List<LawMaterialEntity> materials,
    String? selectedLawId,
    String? selectedMaterialId,
    @Default(1) int selectedLevel,
    Failure? failure,
    @Default(false) bool isAddingQuestion,
    @Default(false) bool addQuestionSuccess,
    @Default('') String searchQuery,
  }) = _QuestionsState;
  factory QuestionsState.initial() => const QuestionsState();
}
