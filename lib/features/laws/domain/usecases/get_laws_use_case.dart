import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/law_entity.dart';
import '../repositories/laws_repository.dart';

class GetLawsUseCase {
  final LawsRepository repository;

  GetLawsUseCase(this.repository);

  Future<Either<Failure, List<LawEntity>>> call({
    int limit = 10,
    LawEntity? lastLaw,
  }) async {
    return await repository.getLaws(limit: limit, lastLaw: lastLaw);
  }
}
