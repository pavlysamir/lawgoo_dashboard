import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../dashboard/domain/entities/user_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Unit>> createAdmin({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, List<UserEntity>>> getAdmins();

  Future<Either<Failure, Unit>> toggleAdminStatus(String adminId, bool isActive);

  Future<Either<Failure, Unit>> deleteAdmin(String adminId);
}
