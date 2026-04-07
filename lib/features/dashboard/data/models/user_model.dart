import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends UserEntity {
  @JsonKey(name: 'createdAt', fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;

  @JsonKey(name: 'lastLoginDate', fromJson: _nullableDateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime? lastLoginDate;

  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    @JsonKey(name: 'profileImage') super.profileImage,
    required this.createdAt,
    @JsonKey(name: 'isActive') required super.isActive,
    super.countCompletedLevels = 0,
    @JsonKey(name: 'totalPoints') super.totalPoints = 0,
    @JsonKey(name: 'correctAnswers') super.correctAnswers = 0,
    @JsonKey(name: 'totalAnswers') super.totalAnswers = 0,
    super.accuracy = 0.0,
    @JsonKey(name: 'currentStreak') super.currentStreak = 0,
    this.lastLoginDate,
    super.role = 'user',
  }) : super(
          createdAt: createdAt,
          lastLoginDate: lastLoginDate,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    // Mapping legacy/mobile camelCase fields to snake_case as per project convention
    // And providing defaults to prevent null-to-type crashes
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);

    data['createdAt'] ??= data['created_at'];
    data['lastLoginDate'] ??= data['last_login_date'];
    data['totalPoints'] ??= data['total_points'] ?? 0;
    data['correctAnswers'] ??= data['correct_answers'] ?? 0;
    data['totalAnswers'] ??= data['total_answers'] ?? 0;
    data['currentStreak'] ??= data['current_streak'] ?? 0;
    data['isActive'] ??= data['is_active'] ?? true;
    data['profileImage'] ??= data['profile_image'];
    data['role'] ??= data['role'] ?? 'user';
    data['accuracy'] ??= data['accuracy'] ?? 0.0;
    data['count_completed_levels'] ??= data['countCompletedLevels'] ?? 0;

    return _$UserModelFromJson({...data, 'id': id});
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static DateTime _dateTimeFromTimestamp(dynamic timestamp) {
    if (timestamp == null) return DateTime.now();
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.tryParse(timestamp) ?? DateTime.now();
    return DateTime.now();
  }

  static dynamic _dateTimeToTimestamp(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }

  static DateTime? _nullableDateTimeFromTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.tryParse(timestamp);
    return null;
  }

  UserEntity toDomain() => this;
}
