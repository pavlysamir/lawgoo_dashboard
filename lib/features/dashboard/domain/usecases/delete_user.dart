import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/dashboard_repository.dart';

class DeleteUser {
  final DashboardRepository repository;

  DeleteUser(this.repository);

  Future<Either<Failure, Unit>> call(String userId) async {
    return await repository.deleteUser(userId);
  }
}
