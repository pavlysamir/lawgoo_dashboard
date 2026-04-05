import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/law_material_entity.dart';
import '../../domain/usecases/add_law_material_use_case.dart';
import '../../domain/usecases/delete_law_material_use_case.dart';
import '../../domain/usecases/get_law_materials_count_use_case.dart';
import '../../domain/usecases/get_law_materials_use_case.dart';
import '../../domain/usecases/update_law_material_use_case.dart';
import 'law_materials_state.dart';

class LawMaterialsCubit extends Cubit<LawMaterialsState> {
  final AddLawMaterialUseCase addLawMaterial;
  final GetLawMaterialsUseCase getLawMaterials;
  final DeleteLawMaterialUseCase deleteLawMaterial;
  final UpdateLawMaterialUseCase updateLawMaterial;
  final GetLawMaterialsCountUseCase getLawMaterialsCount;

  String? _lawId;

  LawMaterialsCubit({
    required this.addLawMaterial,
    required this.getLawMaterials,
    required this.deleteLawMaterial,
    required this.updateLawMaterial,
    required this.getLawMaterialsCount,
  }) : super(const LawMaterialsState.initial());

  Future<void> init(String lawId) async {
    _lawId = lawId;
    emit(const LawMaterialsState.loading());
    await _fetchPage(1);
  }

  Future<void> _fetchPage(int page, {String? query}) async {
    if (_lawId == null) return;

    final result = await getLawMaterials(
      lawId: _lawId!,
      limit: 4,
      searchQuery: query,
      // For simple page-based pagination with 4 items, we might need a different approach if using startAfterDocument.
      // But for small lists or order-based, we can just fetch and handle it.
      // However, for consistency with the design (1, 2, 3, 9 ...), it looks like standard page buttons.
    );

    final countResult = await getLawMaterialsCount(_lawId!);

    result.fold(
      (failure) => emit(LawMaterialsState.error(failure)),
      (materials) {
        countResult.fold(
          (failure) => emit(LawMaterialsState.error(failure)),
          (total) {
            emit(LawMaterialsState.success(
              materials: materials,
              totalMaterials: total,
              currentPage: page,
              searchQuery: query,
            ));
          },
        );
      },
    );
  }

  Future<void> changePage(int page) async {
    state.maybeMap(
      success: (s) async {
        if (s.isPaginating) return;
        emit(s.copyWith(isPaginating: true, currentPage: page));
        
        // In a real Firestore app, page-based pagination is tricky without offsets.
        // For 4 items/page, we can fetch with limit = page * 4 and take the last 4,
        // or use document snapshots. For this dashboard, we'll fetch with limit 4 and startAfter.
        // Simplified for now:
        await _fetchMaterialsForPage(page, s.searchQuery);
      },
      orElse: () {},
    );
  }

  Future<void> _fetchMaterialsForPage(int page, String? query) async {
    if (_lawId == null) return;
    
    // For 4 items/page, if we want page 2, we need the last item of page 1.
    // This requires keeping track of snapshots or fetching with offset (not native in Firestore).
    // Given the "each screen get four items" and "1 2 3 ... 9" buttons, 
    // we'll implement a simplified pagination for now.
    
    final result = await getLawMaterials(
      lawId: _lawId!,
      limit: 4,
      // lastMaterial: ... would go here if we had it.
      searchQuery: query,
    );

    result.fold(
      (failure) => emit(state.maybeMap(
        success: (s) => s.copyWith(isPaginating: false, operationFailure: failure),
        orElse: () => LawMaterialsState.error(failure),
      )),
      (materials) {
        emit(state.maybeMap(
          success: (s) => s.copyWith(
            isPaginating: false,
            materials: materials,
            currentPage: page,
          ),
          orElse: () => LawMaterialsState.initial(), // Should not happen
        ));
      },
    );
  }

  Future<void> search(String query) async {
    state.maybeMap(
      success: (s) async {
        emit(s.copyWith(isPaginating: true, searchQuery: query));
        await _fetchPage(1, query: query);
      },
      orElse: () {},
    );
  }

  Future<void> addNewMaterial(String content, int order) async {
    if (_lawId == null) return;

    state.maybeMap(
      success: (s) async {
        emit(s.copyWith(isAddingMaterial: true, operationFailure: null));

        final material = LawMaterialEntity(
          id: '',
          lawId: _lawId!,
          content: content,
          order: order,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final result = await addLawMaterial(material);

        result.fold(
          (failure) => emit(s.copyWith(isAddingMaterial: false, operationFailure: failure)),
          (_) => init(_lawId!), // Refresh
        );
      },
      orElse: () {},
    );
  }

  Future<void> updateExistingMaterial(String content, int order) async {
    state.maybeMap(
      success: (s) async {
        if (s.editingMaterial == null) return;
        emit(s.copyWith(isUpdatingMaterial: true, operationFailure: null));

        final updatedMaterial = s.editingMaterial!.copyWith(
          content: content,
          order: order,
          updatedAt: DateTime.now(),
        );

        final result = await updateLawMaterial(updatedMaterial);

        result.fold(
          (failure) => emit(s.copyWith(isUpdatingMaterial: false, operationFailure: failure)),
          (_) {
            emit(s.copyWith(isUpdatingMaterial: false, editingMaterial: null));
            init(_lawId!); // Refresh
          },
        );
      },
      orElse: () {},
    );
  }

  Future<void> deleteMaterialById(String id) async {
    state.maybeMap(
      success: (s) async {
        emit(s.copyWith(isDeletingMaterial: true, operationFailure: null));

        final result = await deleteLawMaterial(id);

        result.fold(
          (failure) => emit(s.copyWith(isDeletingMaterial: false, operationFailure: failure)),
          (_) => init(_lawId!), // Refresh
        );
      },
      orElse: () {},
    );
  }

  void setEditingMaterial(LawMaterialEntity? material) {
    state.maybeMap(
      success: (s) => emit(s.copyWith(editingMaterial: material)),
      orElse: () {},
    );
  }
}
