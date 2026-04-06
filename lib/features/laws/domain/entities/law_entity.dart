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

  LawEntity copyWith({
    String? id,
    String? name,
    int? totalLevels,
    int? completedLevelsCount,
    int? completionPercentage,
    int? materialsCount,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return LawEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      totalLevels: totalLevels ?? this.totalLevels,
      completedLevelsCount: completedLevelsCount ?? this.completedLevelsCount,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      materialsCount: materialsCount ?? this.materialsCount,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

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
