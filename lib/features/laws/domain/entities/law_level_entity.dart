import 'package:equatable/equatable.dart';

class LawLevelEntity extends Equatable {
  final String id;
  final String lawId;
  final int levelNumber;
  final String title;
  final int questionsCount;
  final int expectedDurationMinutes;
  final int rewardPoints;
  final int order;
  final bool isActive;

  const LawLevelEntity({
    required this.id,
    required this.lawId,
    required this.levelNumber,
    required this.title,
    required this.questionsCount,
    required this.expectedDurationMinutes,
    required this.rewardPoints,
    required this.order,
    required this.isActive,
  });

  LawLevelEntity copyWith({
    String? id,
    String? lawId,
    int? levelNumber,
    String? title,
    int? questionsCount,
    int? expectedDurationMinutes,
    int? rewardPoints,
    int? order,
    bool? isActive,
  }) {
    return LawLevelEntity(
      id: id ?? this.id,
      lawId: lawId ?? this.lawId,
      levelNumber: levelNumber ?? this.levelNumber,
      title: title ?? this.title,
      questionsCount: questionsCount ?? this.questionsCount,
      expectedDurationMinutes:
          expectedDurationMinutes ?? this.expectedDurationMinutes,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        lawId,
        levelNumber,
        title,
        questionsCount,
        expectedDurationMinutes,
        rewardPoints,
        order,
        isActive,
      ];
}
