import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/laws_repository.dart';

class DeleteLawUseCase {
  final LawsRepository repository;

  DeleteLawUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String lawId) async {
    return await repository.deleteLaw(lawId);
  }
}
