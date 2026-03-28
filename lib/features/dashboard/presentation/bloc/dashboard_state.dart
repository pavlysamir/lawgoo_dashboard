import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/dashboard_stats_entity.dart';
import '../../domain/entities/user_entity.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = _Initial;
  const factory DashboardState.loading() = _Loading;
  const factory DashboardState.success({
    required DashboardStatsEntity stats,
    required List<UserEntity> users,
    @Default(false) bool isPaginating,
    Failure? paginationFailure,
    @Default(1) int currentPage,
  }) = _Success;
  const factory DashboardState.error(Failure failure) = _Error;
}
