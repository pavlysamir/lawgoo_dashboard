import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class CreateAdminUseCase {
  final SettingsRepository repository;

  CreateAdminUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await repository.createAdmin(
      name: name,
      email: email,
      password: password,
    );
  }
}
