import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetUsers {
  final DashboardRepository repository;

  GetUsers(this.repository);

  Future<Either<Failure, List<UserEntity>>> call({int limit = 4, UserEntity? lastUser}) async {
    return await repository.getUsers(limit: limit, lastUser: lastUser);
  }
}
