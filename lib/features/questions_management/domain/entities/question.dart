import 'package:equatable/equatable.dart';
import 'answer.dart';

class Question extends Equatable {
  final String? questionId;
  final String lawId;
  final String materialId;
  final int level;
  final String questionText;
  final List<Answer> answers;
  final String difficulty;
  final String type;
  final bool isShared;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDeleted;

  const Question({
    this.questionId,
    required this.lawId,
    required this.materialId,
    required this.level,
    required this.questionText,
    required this.answers,
    required this.difficulty,
    required this.type,
    this.isShared = false,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  Question copyWith({
    String? questionId,
    String? lawId,
    String? materialId,
    int? level,
    String? questionText,
    List<Answer>? answers,
    String? difficulty,
    String? type,
    bool? isShared,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return Question(
      questionId: questionId ?? this.questionId,
      lawId: lawId ?? this.lawId,
      materialId: materialId ?? this.materialId,
      level: level ?? this.level,
      questionText: questionText ?? this.questionText,
      answers: answers ?? this.answers,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      isShared: isShared ?? this.isShared,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        questionId,
        lawId,
        materialId,
        level,
        questionText,
        answers,
        difficulty,
        type,
        isShared,
        isActive,
        createdAt,
        updatedAt,
        isDeleted,
      ];
}
