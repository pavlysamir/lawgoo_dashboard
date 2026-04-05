// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'law_material_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LawMaterialModel _$LawMaterialModelFromJson(Map<String, dynamic> json) =>
    LawMaterialModel(
      id: json['id'] as String,
      lawId: json['law_id'] as String,
      content: json['content'] as String,
      order: (json['order'] as num).toInt(),
      createdAt: LawMaterialModel._dateTimeFromTimestamp(
        json['created_at'] as Timestamp,
      ),
      updatedAt: LawMaterialModel._dateTimeFromTimestamp(
        json['updated_at'] as Timestamp,
      ),
    );

Map<String, dynamic> _$LawMaterialModelToJson(LawMaterialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'law_id': instance.lawId,
      'content': instance.content,
      'order': instance.order,
      'created_at': LawMaterialModel._dateTimeToTimestamp(instance.createdAt),
      'updated_at': LawMaterialModel._dateTimeToTimestamp(instance.updatedAt),
    };
