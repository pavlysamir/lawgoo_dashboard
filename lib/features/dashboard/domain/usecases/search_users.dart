import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/dashboard_repository.dart';

class SearchUsers {
  final DashboardRepository repository;

  SearchUsers(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(String query) async {
    return await repository.searchUsers(query);
  }
}
