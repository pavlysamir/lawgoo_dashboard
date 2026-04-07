import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class DeleteAdminUseCase {
  final SettingsRepository repository;

  DeleteAdminUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String adminId) async {
    return await repository.deleteAdmin(adminId);
  }
}
