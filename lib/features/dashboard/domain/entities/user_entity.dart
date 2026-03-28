import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final DateTime createdAt;
  final bool isActive;
  final int countCompletedLevels;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    required this.createdAt,
    required this.isActive,
    required this.countCompletedLevels,
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
      ];
}
