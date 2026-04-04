import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/laws_repository.dart';

class GetLawsCountUseCase {
  final LawsRepository repository;

  GetLawsCountUseCase(this.repository);

  Future<Either<Failure, (int total, int active)>> call() async {
    final totalResult = await repository.getLawsCount();
    final activeResult = await repository.getActiveLawsCount();

    return totalResult.fold(
      (failure) => Left(failure),
      (total) => activeResult.fold(
        (failure) => Left(failure),
        (active) => Right((total, active)),
      ),
    );
  }
}
