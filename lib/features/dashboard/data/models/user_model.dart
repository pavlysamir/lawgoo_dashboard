import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;

  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.profileImage,
    required this.createdAt,
    required super.isActive,
    super.countCompletedLevels = 0,
  }) : super(
          createdAt: createdAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return _$UserModelFromJson({...json, 'id': id});
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  UserEntity toDomain() => this;
}
