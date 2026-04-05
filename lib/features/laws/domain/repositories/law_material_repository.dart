import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/law_material_entity.dart';

abstract class LawMaterialRepository {
  Future<Either<Failure, List<LawMaterialEntity>>> getLawMaterials(
    String lawId, {
    int limit = 10,
    LawMaterialEntity? lastMaterial,
    String? searchQuery,
  });

  Future<Either<Failure, int>> getLawMaterialsCount(String lawId);

  Future<Either<Failure, Unit>> addLawMaterial(LawMaterialEntity material);

  Future<Either<Failure, Unit>> updateLawMaterial(LawMaterialEntity material);

  Future<Either<Failure, Unit>> deleteLawMaterial(String materialId);
}
