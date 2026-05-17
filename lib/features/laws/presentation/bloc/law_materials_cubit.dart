import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/law_material_entity.dart';
import '../../domain/usecases/add_law_material_use_case.dart';
import '../../domain/usecases/delete_law_material_use_case.dart';
import '../../domain/usecases/get_law_materials_count_use_case.dart';
import '../../domain/usecases/get_law_materials_use_case.dart';
import '../../domain/usecases/update_law_material_use_case.dart';
import 'law_materials_state.dart';

class LawMaterialsCubit extends Cubit<LawMaterialsState> {
  static const int _itemsPerPage = 4;

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

    final countResult = await getLawMaterialsCount(_lawId!);
    await countResult.fold(
      (failure) async => emit(LawMaterialsState.error(failure)),
      (total) async {
        final safePage = _getSafePage(page, total);
        final result = await getLawMaterials(
          lawId: _lawId!,
          limit: safePage * _itemsPerPage,
          searchQuery: query,
        );

        result.fold(
          (failure) => emit(LawMaterialsState.error(failure)),
          (materials) => emit(
            LawMaterialsState.success(
              materials: _getPageItems(materials, safePage),
              totalMaterials: total,
              currentPage: safePage,
              searchQuery: query,
            ),
          ),
        );
      },
    );
  }

  Future<void> changePage(int page) async {
    state.maybeMap(
      success: (s) async {
        if (s.isPaginating) return;
        final totalPages = (s.totalMaterials / s.itemsPerPage).ceil();
        if (page < 1 || page > totalPages || page == s.currentPage) return;

        emit(s.copyWith(isPaginating: true, currentPage: page));
        await _fetchPage(page, query: s.searchQuery);
      },
      orElse: () {},
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
          (failure) => emit(
            s.copyWith(isAddingMaterial: false, operationFailure: failure),
          ),
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
          (failure) => emit(
            s.copyWith(isUpdatingMaterial: false, operationFailure: failure),
          ),
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
          (failure) => emit(
            s.copyWith(isDeletingMaterial: false, operationFailure: failure),
          ),
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

  int _getSafePage(int page, int totalItems) {
    final totalPages = (totalItems / _itemsPerPage).ceil();
    if (totalPages == 0) return 1;
    return page.clamp(1, totalPages).toInt();
  }

  List<LawMaterialEntity> _getPageItems(
    List<LawMaterialEntity> materials,
    int page,
  ) {
    final startIndex = (page - 1) * _itemsPerPage;
    if (startIndex >= materials.length) return const [];
    final endIndex = startIndex + _itemsPerPage > materials.length
        ? materials.length
        : startIndex + _itemsPerPage;
    return materials.sublist(startIndex, endIndex);
  }
}
