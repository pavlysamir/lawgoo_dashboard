import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/settings_repository.dart';

class ToggleAdminStatusUseCase {
  final SettingsRepository repository;

  ToggleAdminStatusUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String adminId, bool isActive) async {
    return await repository.toggleAdminStatus(adminId, isActive);
  }
}
