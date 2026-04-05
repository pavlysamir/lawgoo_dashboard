import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/law_material_entity.dart';

part 'law_material_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LawMaterialModel extends LawMaterialEntity {
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime createdAt;
  @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
  final DateTime updatedAt;

  const LawMaterialModel({
    required super.id,
    required super.lawId,
    required super.content,
    required super.order,
    required this.createdAt,
    required this.updatedAt,
  }) : super(
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory LawMaterialModel.fromJson(Map<String, dynamic> json, String id) {
    return _$LawMaterialModelFromJson({
      ...json,
      'id': id,
    });
  }

  Map<String, dynamic> toJson() {
    final json = _$LawMaterialModelToJson(this);
    json.remove('id'); // ID is usually outside the document in Firestore
    return json;
  }

  static DateTime _dateTimeFromTimestamp(Timestamp timestamp) =>
      timestamp.toDate();

  static Timestamp _dateTimeToTimestamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);

  factory LawMaterialModel.fromEntity(LawMaterialEntity entity) {
    return LawMaterialModel(
      id: entity.id,
      lawId: entity.lawId,
      content: entity.content,
      order: entity.order,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  LawMaterialEntity toDomain() => this;
}
