import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/law_material_repository.dart';

class GetLawMaterialsCountUseCase {
  final LawMaterialRepository repository;

  GetLawMaterialsCountUseCase(this.repository);

  Future<Either<Failure, int>> call(String lawId) async {
    return await repository.getLawMaterialsCount(lawId);
  }
}
