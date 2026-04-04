import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/law_entity.dart';

part 'law_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LawModel extends LawEntity {
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;

  const LawModel({
    required super.id,
    required super.name,
    required super.totalLevels,
    required super.completedLevelsCount,
    required super.completionPercentage,
    required super.materialsCount,
    required this.createdAt,
    required super.isActive,
  }) : super(
          createdAt: createdAt,
        );

  factory LawModel.fromJson(Map<String, dynamic> json, String id) {
    return _$LawModelFromJson({'id': id, ...json});
  }

  Map<String, dynamic> toJson() => _$LawModelToJson(this);

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  factory LawModel.fromEntity(LawEntity entity) {
    return LawModel(
      id: entity.id,
      name: entity.name,
      totalLevels: entity.totalLevels,
      completedLevelsCount: entity.completedLevelsCount,
      completionPercentage: entity.completionPercentage,
      materialsCount: entity.materialsCount,
      createdAt: entity.createdAt,
      isActive: entity.isActive,
    );
  }

  LawEntity toDomain() => this;
}
