import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lowgos_dashboard/core/error/failures.dart';
import '../../../laws/domain/usecases/get_laws_use_case.dart';
import '../../../laws/domain/usecases/get_law_materials_use_case.dart';
import '../../domain/entities/question.dart';
import '../../domain/usecases/add_question_usecase.dart';
import '../../domain/usecases/get_questions_usecase.dart';
import '../../domain/usecases/toggle_question_status_usecase.dart';
import '../../domain/usecases/delete_question_usecase.dart';
import '../../domain/usecases/share_question_usecase.dart';
import '../../domain/usecases/update_question_usecase.dart';
import 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final AddQuestionUseCase addQuestion;
  final GetQuestionsUseCase getQuestions;
  final ToggleQuestionStatusUseCase toggleStatus;
  final DeleteQuestionUseCase deleteQuestion;
  final ShareQuestionUseCase shareQuestion;
  final UpdateQuestionUseCase updateQuestion;
  final GetLawsUseCase getLaws;
  final GetLawMaterialsUseCase getLawMaterials;

  QuestionsCubit({
    required this.addQuestion,
    required this.getQuestions,
    required this.toggleStatus,
    required this.deleteQuestion,
    required this.shareQuestion,
    required this.updateQuestion,
    required this.getLaws,
    required this.getLawMaterials,
  }) : super(QuestionsState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    await _fetchLaws();
    // Questions will be fetched when selectLaw is called or manually here if needed
    if (state.selectedLawId != null) {
      await _fetchQuestions();
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _fetchLaws() async {
    final result = await getLaws();
    result.fold((failure) => emit(state.copyWith(failure: failure)), (laws) {
      emit(state.copyWith(laws: laws));
      if (laws.isNotEmpty && state.selectedLawId == null) {
        selectLaw(laws.first.id);
      }
    });
  }

  Future<void> selectLaw(String lawId) async {
    emit(
      state.copyWith(
        selectedLawId: lawId,
        selectedMaterialId: null,
        materials: [],
      ),
    );
    await _fetchMaterials(lawId);
    await _fetchQuestions();
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
    final result = await getQuestions(state.selectedLawId);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure)),
      (questions) => emit(state.copyWith(questions: questions)),
    );
  }

  Future<void> addNewQuestion(Question question) async {
    if (state.selectedLawId == null) {
      emit(state.copyWith(failure: const ServerFailure('يرجى اختيار القانون')));
      return;
    }

    emit(state.copyWith(isAddingQuestion: true, addQuestionSuccess: false));

    final finalQuestion = question.copyWith(
      lawId: state.selectedLawId,
      level: state.selectedLevel,
    );

    final result = await addQuestion(finalQuestion);
    result.fold(
      (failure) =>
          emit(state.copyWith(isAddingQuestion: false, failure: failure)),
      (_) {
        emit(state.copyWith(isAddingQuestion: false, addQuestionSuccess: true));
        _fetchQuestions();
      },
    );
  }

  Future<void> updateExistingQuestion(Question question) async {
    emit(state.copyWith(isAddingQuestion: true, addQuestionSuccess: false));

    final result = await updateQuestion(question);
    result.fold(
      (failure) =>
          emit(state.copyWith(isAddingQuestion: false, failure: failure)),
      (_) {
        emit(
          state.copyWith(
            isAddingQuestion: false,
            addQuestionSuccess: true,
            editingQuestion: null,
          ),
        );
        _fetchQuestions();
      },
    );
  }

  void editQuestion(Question? question) {
    emit(state.copyWith(editingQuestion: question));
  }

  Future<void> toggleQuestionActive(String questionId, bool isActive) async {
    final result = await toggleStatus(
      ToggleQuestionParams(questionId: questionId, isActive: isActive),
    );
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
    return state.questions.where((q) {
      final matchesLaw =
          state.selectedLawId == null || q.lawId == state.selectedLawId;
      final matchesLevel = q.level == state.selectedLevel;
      final matchesSearch =
          state.searchQuery.isEmpty ||
          q.questionText.toLowerCase().contains(
            state.searchQuery.toLowerCase(),
          );
      return matchesLaw && matchesLevel && matchesSearch;
    }).toList();
  }
}
