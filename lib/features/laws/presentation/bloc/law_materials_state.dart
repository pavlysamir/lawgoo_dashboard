import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/law_material_entity.dart';

part 'law_materials_state.freezed.dart';

@freezed
class LawMaterialsState with _$LawMaterialsState {
  const factory LawMaterialsState.initial() = _Initial;
  const factory LawMaterialsState.loading() = _Loading;
  const factory LawMaterialsState.success({
    required List<LawMaterialEntity> materials,
    required int totalMaterials,
    @Default(1) int currentPage,
    @Default(4) int itemsPerPage,
    @Default(false) bool isPaginating,
    @Default(false) bool isAddingMaterial,
    @Default(false) bool isDeletingMaterial,
    @Default(false) bool isUpdatingMaterial,
    String? searchQuery,
    LawMaterialEntity? editingMaterial,
    Failure? operationFailure,
  }) = _Success;
  const factory LawMaterialsState.error(Failure failure) = _Error;
}
