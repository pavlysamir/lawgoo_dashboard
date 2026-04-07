import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../dashboard/domain/entities/user_entity.dart';
import '../repositories/settings_repository.dart';

class GetAdminsUseCase {
  final SettingsRepository repository;

  GetAdminsUseCase(this.repository);

  Future<Either<Failure, List<UserEntity>>> call() async {
    return await repository.getAdmins();
  }
}
