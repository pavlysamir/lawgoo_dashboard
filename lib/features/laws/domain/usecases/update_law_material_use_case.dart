import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/law_material_entity.dart';
import '../repositories/law_material_repository.dart';

class UpdateLawMaterialUseCase {
  final LawMaterialRepository repository;

  UpdateLawMaterialUseCase(this.repository);

  Future<Either<Failure, Unit>> call(LawMaterialEntity material) async {
    return await repository.updateLawMaterial(material);
  }
}
