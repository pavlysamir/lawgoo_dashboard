import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/law_entity.dart';
import '../../domain/usecases/get_laws_use_case.dart';
import '../../domain/usecases/add_law_use_case.dart';
import '../../domain/usecases/get_laws_count_use_case.dart';
import 'laws_state.dart';

class LawsCubit extends Cubit<LawsState> {
  final GetLawsUseCase getLaws;
  final AddLawUseCase addLaw;
  final GetLawsCountUseCase getLawsCount;

  LawsCubit({
    required this.getLaws,
    required this.addLaw,
    required this.getLawsCount,
  }) : super(const LawsState.initial());

  Future<void> init() async {
    emit(const LawsState.loading());

    final countsResult = await getLawsCount();
    final lawsResult = await getLaws(limit: 10);

    countsResult.fold(
      (failure) {
        emit(LawsState.error(failure));
      },
      (counts) {
        lawsResult.fold(
          (failure) {
            emit(LawsState.error(failure));
          },
          (laws) => emit(
            LawsState.success(
              laws: laws,
              totalLaws: counts.$1,
              activeLaws: counts.$2,
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchNextPage() async {
    await state.maybeMap(
      success: (successState) async {
        if (successState.isPaginating) return;

        emit(
          successState.copyWith(isPaginating: true, paginationFailure: null),
        );

        final lastLaw = successState.laws.isNotEmpty
            ? successState.laws.last
            : null;
        final result = await getLaws(limit: 10, lastLaw: lastLaw);

        result.fold(
          (failure) => emit(
            successState.copyWith(
              isPaginating: false,
              paginationFailure: failure,
            ),
          ),
          (newLaws) {
            emit(
              successState.copyWith(
                isPaginating: false,
                laws: [...successState.laws, ...newLaws],
              ),
            );
          },
        );
      },
      orElse: () async {},
    );
  }

  void toggleAddForm() {
    state.maybeMap(
      success: (successState) {
        emit(successState.copyWith(showAddForm: !successState.showAddForm));
      },
      orElse: () {},
    );
  }

  Future<void> addNewLaw(String name, int totalLevels) async {
    await state.maybeMap(
      success: (successState) async {
        emit(successState.copyWith(isAddingLaw: true, addLawFailure: null));

        final newLaw = LawEntity(
          id: '',
          name: name,
          totalLevels: totalLevels,
          completedLevelsCount: 0,
          completionPercentage: 0,
          materialsCount: 0,
          createdAt: DateTime.now(),
          isActive: true,
        );

        final result = await addLaw(newLaw);

        result.fold(
          (failure) => emit(
            successState.copyWith(isAddingLaw: false, addLawFailure: failure),
          ),
          (_) {
            // After successful addition, we can either refresh or manually update state
            // Refreshing is safer
            init();
          },
        );
      },
      orElse: () async {},
    );
  }
}
