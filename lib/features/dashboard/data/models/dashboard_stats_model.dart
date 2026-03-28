import '../../domain/entities/dashboard_stats_entity.dart';

class DashboardStatsModel extends DashboardStatsEntity {
  const DashboardStatsModel({
    super.totalUsers,
    super.totalQuestions,
    super.totalMaterials,
    required super.isSystemActive,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalUsers: json['total_users'] as int?,
      totalQuestions: json['total_questions'] as int?,
      totalMaterials: json['total_materials'] as int?,
      isSystemActive: json['is_system_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_users': totalUsers,
      'total_questions': totalQuestions,
      'total_materials': totalMaterials,
      'is_system_active': isSystemActive,
    };
  }
}
