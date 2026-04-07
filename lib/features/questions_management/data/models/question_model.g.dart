// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      questionId: json['question_id'] as String?,
      lawId: json['law_id'] as String,
      materialId: json['material_id'] as String,
      level: (json['level'] as num).toInt(),
      questionText: json['question_text'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      difficulty: json['difficulty'] as String,
      type: json['type'] as String,
      isShared: json['is_shared'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'question_id': instance.questionId,
      'law_id': instance.lawId,
      'material_id': instance.materialId,
      'level': instance.level,
      'question_text': instance.questionText,
      'difficulty': instance.difficulty,
      'type': instance.type,
      'is_shared': instance.isShared,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_deleted': instance.isDeleted,
      'answers': instance.answers.map((e) => e.toJson()).toList(),
    };
