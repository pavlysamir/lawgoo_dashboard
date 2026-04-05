import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/law_material_entity.dart';
import '../repositories/law_material_repository.dart';

class GetLawMaterialsUseCase {
  final LawMaterialRepository repository;

  GetLawMaterialsUseCase(this.repository);

  Future<Either<Failure, List<LawMaterialEntity>>> call({
    required String lawId,
    int limit = 10,
    LawMaterialEntity? lastMaterial,
    String? searchQuery,
  }) async {
    return await repository.getLawMaterials(
      lawId,
      limit: limit,
      lastMaterial: lastMaterial,
      searchQuery: searchQuery,
    );
  }
}
