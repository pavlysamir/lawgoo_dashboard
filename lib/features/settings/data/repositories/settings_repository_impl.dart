import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../dashboard/domain/entities/user_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Unit>> createAdmin({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await remoteDataSource.createAdmin(
        name: name,
        email: email,
        password: password,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAdmins() async {
    try {
      final admins = await remoteDataSource.getAdmins();
      return Right(admins);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleAdminStatus(String adminId, bool isActive) async {
    try {
      await remoteDataSource.toggleAdminStatus(adminId, isActive);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAdmin(String adminId) async {
    try {
      await remoteDataSource.deleteAdmin(adminId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
