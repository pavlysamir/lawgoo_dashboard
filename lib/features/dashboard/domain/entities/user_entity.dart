import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final DateTime createdAt;
  final bool isActive;
  final int countCompletedLevels;
  
  // stats
  final int totalPoints;
  final int correctAnswers;
  final int totalAnswers;
  final double accuracy;

  // streak
  final int currentStreak;
  final DateTime? lastLoginDate;

  // role
  final String role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    required this.createdAt,
    required this.isActive,
    this.countCompletedLevels = 0,
    this.totalPoints = 0,
    this.correctAnswers = 0,
    this.totalAnswers = 0,
    this.accuracy = 0.0,
    this.currentStreak = 0,
    this.lastLoginDate,
    this.role = 'user',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        profileImage,
        createdAt,
        isActive,
        countCompletedLevels,
        totalPoints,
        correctAnswers,
        totalAnswers,
        accuracy,
        currentStreak,
        lastLoginDate,
        role,
      ];
}
