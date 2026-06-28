// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawModel _$LawModelFromJson(Map<String, dynamic> json) => LawModel(
  id: json['id'] as String,
  name: json['name'] as String,
  totalLevels: (json['total_levels'] as num).toInt(),
  completedLevelsCount: (json['completed_levels_count'] as num).toInt(),
  completionPercentage: (json['completion_percentage'] as num).toInt(),
  materialsCount: (json['materials_count'] as num).toInt(),
  totalQuestions: (json['total_questions'] as num).toInt(),
  totalActiveQuestions: (json['total_active_questions'] as num?)?.toInt() ?? 0,
  createdAt: LawModel._dateTimeFromTimestamp(json['created_at'] as Timestamp),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$LawModelToJson(LawModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'total_levels': instance.totalLevels,
  'completed_levels_count': instance.completedLevelsCount,
  'completion_percentage': instance.completionPercentage,
  'materials_count': instance.materialsCount,
  'total_questions': instance.totalQuestions,
  'total_active_questions': instance.totalActiveQuestions,
  'is_active': instance.isActive,
  'created_at': LawModel._dateTimeToTimestamp(instance.createdAt),
};
