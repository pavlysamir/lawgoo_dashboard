// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawLevelModel _$LawLevelModelFromJson(Map<String, dynamic> json) =>
    LawLevelModel(
      id: json['id'] as String,
      lawId: json['law_id'] as String,
      levelNumber: (json['level_number'] as num).toInt(),
      title: json['title'] as String,
      questionsCount: (json['questions_count'] as num).toInt(),
      expectedDurationMinutes: (json['expected_duration_minutes'] as num)
          .toInt(),
      rewardPoints: (json['reward_points'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$LawLevelModelToJson(LawLevelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'law_id': instance.lawId,
      'level_number': instance.levelNumber,
      'title': instance.title,
      'questions_count': instance.questionsCount,
      'expected_duration_minutes': instance.expectedDurationMinutes,
      'reward_points': instance.rewardPoints,
      'order': instance.order,
      'is_active': instance.isActive,
    };
