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
  createdAt: UserModel._dateTimeFromTimestamp(json['createdAt'] as Timestamp),
  isActive: json['isActive'] as bool,
  countCompletedLevels: (json['countCompletedLevels'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'profileImage': instance.profileImage,
  'isActive': instance.isActive,
  'countCompletedLevels': instance.countCompletedLevels,
  'createdAt': UserModel._dateTimeToTimestamp(instance.createdAt),
};
