import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_stats_entity.dart';
import '../repositories/dashboard_repository.dart';

class GetDashboardStats {
  final DashboardRepository repository;

  GetDashboardStats(this.repository);

  Future<Either<Failure, DashboardStatsEntity>> call() async {
    return await repository.getDashboardStats();
  }
}
