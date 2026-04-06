import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/laws_repository.dart';

class ToggleLawActiveUseCase {
  final LawsRepository repository;

  ToggleLawActiveUseCase(this.repository);

  Future<Either<Failure, Unit>> call(ToggleLawActiveParams params) async {
    return await repository.toggleLawActive(params.id, params.isActive);
  }
}

class ToggleLawActiveParams {
  final String id;
  final bool isActive;

  ToggleLawActiveParams({required this.id, required this.isActive});
}
