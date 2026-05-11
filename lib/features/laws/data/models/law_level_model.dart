import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/law_level_entity.dart';

part 'law_level_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LawLevelModel extends LawLevelEntity {
  const LawLevelModel({
    required super.id,
    required super.lawId,
    required super.levelNumber,
    required super.title,
    required super.questionsCount,
    required super.expectedDurationMinutes,
    required super.rewardPoints,
    required super.order,
    required super.isActive,
  });

  factory LawLevelModel.fromJson(Map<String, dynamic> json) =>
      _$LawLevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LawLevelModelToJson(this);

  factory LawLevelModel.fromEntity(LawLevelEntity entity) {
    return LawLevelModel(
      id: entity.id,
      lawId: entity.lawId,
      levelNumber: entity.levelNumber,
      title: entity.title,
      questionsCount: entity.questionsCount,
      expectedDurationMinutes: entity.expectedDurationMinutes,
      rewardPoints: entity.rewardPoints,
      order: entity.order,
      isActive: entity.isActive,
    );
  }

  LawLevelEntity toDomain() => this;
}
