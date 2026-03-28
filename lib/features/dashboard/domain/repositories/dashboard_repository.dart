import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_stats_entity.dart';
import '../entities/user_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardStatsEntity>> getDashboardStats();
  Future<Either<Failure, List<UserEntity>>> getUsers({
    int limit = 4,
    UserEntity? lastUser,
  });
  Future<Either<Failure, List<UserEntity>>> searchUsers(String query);
}
