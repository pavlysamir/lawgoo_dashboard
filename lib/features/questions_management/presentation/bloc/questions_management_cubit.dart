import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../laws/domain/usecases/get_laws_count_use_case.dart';
import '../../../laws/domain/usecases/get_laws_use_case.dart';
import '../../../laws/domain/usecases/toggle_law_active_use_case.dart';
import 'questions_management_state.dart';

class QuestionsManagementCubit extends Cubit<QuestionsManagementState> {
  final GetLawsUseCase getLaws;
  final GetLawsCountUseCase getLawsCount;
  final ToggleLawActiveUseCase toggleLawActive;

  QuestionsManagementCubit({
    required this.getLaws,
    required this.getLawsCount,
    required this.toggleLawActive,
  }) : super(const QuestionsManagementState.initial());

  Future<void> init() async {
    emit(const QuestionsManagementState.loading());
    await _fetchData();
  }

  Future<void> _fetchData() async {
    final lawsResult = await getLaws();
    final countResult = await getLawsCount();

    lawsResult.fold(
      (failure) => emit(QuestionsManagementState.error(failure)),
      (laws) {
        countResult.fold(
          (failure) => emit(QuestionsManagementState.error(failure)),
          (count) {
            emit(
              QuestionsManagementState.success(
                laws: laws,
                totalLaws: count.$1,
                activeLaws: count.$2,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> toggleActiveStatus(String lawId, bool isActive) async {
    // Extract current success state data using maybeMap
    final successData = state.maybeMap(success: (s) => s, orElse: () => null);
    if (successData == null) return;

    emit(
      successData.copyWith(isTogglingActive: true, toggleActiveFailure: null),
    );

    final result = await toggleLawActive(
      ToggleLawActiveParams(id: lawId, isActive: isActive),
    );

    result.fold(
      (failure) => emit(
        successData.copyWith(
          isTogglingActive: false,
          toggleActiveFailure: failure,
        ),
      ),
      (_) {
        final updatedLaws = successData.laws.map((l) {
          if (l.id == lawId) {
            return l.copyWith(isActive: isActive);
          }
          return l;
        }).toList();

        final activeCount = updatedLaws.where((l) => l.isActive).length;
        emit(
          successData.copyWith(
            isTogglingActive: false,
            laws: updatedLaws,
            activeLaws: activeCount,
          ),
        );
      },
    );
  }
}
