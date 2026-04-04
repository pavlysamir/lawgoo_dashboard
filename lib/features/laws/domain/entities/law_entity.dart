import 'package:equatable/equatable.dart';

class LawEntity extends Equatable {
  final String id;
  final String name;
  final int totalLevels;
  final int completedLevelsCount;
  final int completionPercentage;
  final int materialsCount;
  final DateTime createdAt;
  final bool isActive;

  const LawEntity({
    required this.id,
    required this.name,
    required this.totalLevels,
    required this.completedLevelsCount,
    required this.completionPercentage,
    required this.materialsCount,
    required this.createdAt,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalLevels,
        completedLevelsCount,
        completionPercentage,
        materialsCount,
        createdAt,
        isActive,
      ];
}
