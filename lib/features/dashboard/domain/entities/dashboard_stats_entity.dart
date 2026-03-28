import 'package:equatable/equatable.dart';

class DashboardStatsEntity extends Equatable {
  final int? totalUsers;
  final int? totalQuestions;
  final int? totalMaterials;
  final bool isSystemActive;

  const DashboardStatsEntity({
    this.totalUsers,
    this.totalQuestions,
    this.totalMaterials,
    required this.isSystemActive,
  });

  @override
  List<Object?> get props => [
        totalUsers,
        totalQuestions,
        totalMaterials,
        isSystemActive,
      ];
}
