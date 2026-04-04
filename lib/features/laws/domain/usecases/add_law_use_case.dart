import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/law_entity.dart';
import '../repositories/laws_repository.dart';

class AddLawUseCase {
  final LawsRepository repository;

  AddLawUseCase(this.repository);

  Future<Either<Failure, Unit>> call(LawEntity law) async {
    return await repository.addLaw(law);
  }
}
