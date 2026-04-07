import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../laws/domain/usecases/get_laws_use_case.dart';
import '../../../laws/domain/usecases/get_law_materials_use_case.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/add_question_usecase.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import '../../domain/usecases/toggle_question_status_usecase.dart';
import '../../domain/usecases/delete_question_usecase.dart';
import '../../domain/usecases/share_question_usecase.dart';
import 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final AddQuestionUseCase addQuestion;
  final GetQuestionsUseCase getQuestions;
  final ToggleQuestionStatusUseCase toggleStatus;
  final DeleteQuestionUseCase deleteQuestion;
  final ShareQuestionUseCase shareQuestion;
  final GetLawsUseCase getLaws;
  final GetLawMaterialsUseCase getLawMaterials;

  QuestionsCubit({
    required this.addQuestion,
    required this.getQuestions,
    required this.toggleStatus,
    required this.deleteQuestion,
    required this.shareQuestion,
    required this.getLaws,
    required this.getLawMaterials,
  }) : super(QuestionsState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    await _fetchLaws();
    await _fetchQuestions();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _fetchLaws() async {
    final result = await getLaws();
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (laws) {
        emit(state.copyWith(laws: laws));
        if (laws.isNotEmpty && state.selectedLawId == null) {
          selectLaw(laws.first.id);
        }
      },
    );
  }

  Future<void> selectLaw(String lawId) async {
    emit(state.copyWith(selectedLawId: lawId, selectedMaterialId: null, materials: []));
    await _fetchMaterials(lawId);
  }

  Future<void> _fetchMaterials(String lawId) async {
    final result = await getLawMaterials(lawId: lawId);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (materials) => emit(state.copyWith(materials: materials)),
    );
  }

  void selectMaterial(String materialId) {
    emit(state.copyWith(selectedMaterialId: materialId));
  }

  void selectLevel(int level) {
    emit(state.copyWith(selectedLevel: level));
  }

  Future<void> _fetchQuestions() async {
    final result = await getQuestions(NoParams());
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (questions) => emit(state.copyWith(questions: questions)),
    );
  }

  Future<void> addNewQuestion(Question question) async {
    emit(state.copyWith(isAddingQuestion: true, addQuestionSuccess: false));
    final result = await addQuestion(question);
    result.fold(
      (failure) => emit(state.copyWith(isAddingQuestion: false, failure: failure)),
      (_) {
        emit(state.copyWith(isAddingQuestion: false, addQuestionSuccess: true));
        _fetchQuestions();
      },
    );
  }

  Future<void> toggleQuestionActive(String questionId, bool isActive) async {
    final result = await toggleStatus(ToggleQuestionParams(questionId: questionId, isActive: isActive));
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) => _fetchQuestions(),
    );
  }

  Future<void> removeQuestion(String questionId) async {
    final result = await deleteQuestion(questionId);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) => _fetchQuestions(),
    );
  }

  Future<void> shareQ(String questionId) async {
    final result = await shareQuestion(questionId);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (_) => _fetchQuestions(),
    );
  }

  void updateSearch(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  List<Question> get filteredQuestions {
    if (state.searchQuery.isEmpty) return state.questions;
    return state.questions
        .where((q) => q.questionText.toLowerCase().contains(state.searchQuery.toLowerCase()))
        .toList();
  }
}
