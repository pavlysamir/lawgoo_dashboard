import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/law_material_repository.dart';

class DeleteLawMaterialUseCase {
  final LawMaterialRepository repository;

  DeleteLawMaterialUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String materialId) async {
    return await repository.deleteLawMaterial(materialId);
  }
}
