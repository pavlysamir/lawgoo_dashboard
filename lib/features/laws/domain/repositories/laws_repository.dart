import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/law_entity.dart';

abstract class LawsRepository {
  Future<Either<Failure, List<LawEntity>>> getLaws({
    int limit = 10,
    LawEntity? lastLaw,
  });
  Future<Either<Failure, int>> getLawsCount();
  Future<Either<Failure, int>> getActiveLawsCount();
  Future<Either<Failure, Unit>> addLaw(LawEntity law);
  Future<Either<Failure, Unit>> deleteLaw(String lawId);
  Future<Either<Failure, Unit>> toggleLawActive(String id, bool isActive);
}
