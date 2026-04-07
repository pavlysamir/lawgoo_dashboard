// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  profileImage: json['profileImage'] as String?,
  createdAt: UserModel._dateTimeFromTimestamp(json['createdAt']),
  isActive: json['isActive'] as bool,
  countCompletedLevels: (json['count_completed_levels'] as num?)?.toInt() ?? 0,
  totalPoints: (json['totalPoints'] as num?)?.toInt() ?? 0,
  correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
  totalAnswers: (json['totalAnswers'] as num?)?.toInt() ?? 0,
  accuracy: (json['accuracy'] as num?)?.toDouble() ?? 0.0,
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  lastLoginDate: UserModel._nullableDateTimeFromTimestamp(
    json['lastLoginDate'],
  ),
  role: json['role'] as String? ?? 'user',
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'profileImage': instance.profileImage,
  'isActive': instance.isActive,
  'count_completed_levels': instance.countCompletedLevels,
  'totalPoints': instance.totalPoints,
  'correctAnswers': instance.correctAnswers,
  'totalAnswers': instance.totalAnswers,
  'accuracy': instance.accuracy,
  'currentStreak': instance.currentStreak,
  'role': instance.role,
  'createdAt': UserModel._dateTimeToTimestamp(instance.createdAt),
  'lastLoginDate': UserModel._dateTimeToTimestamp(instance.lastLoginDate),
};
