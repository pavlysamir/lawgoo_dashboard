import 'package:equatable/equatable.dart';

class LawMaterialEntity extends Equatable {
  final String id;
  final String lawId;
  final String content;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LawMaterialEntity({
    required this.id,
    required this.lawId,
    required this.content,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, lawId, content, order, createdAt, updatedAt];

  LawMaterialEntity copyWith({
    String? id,
    String? lawId,
    String? content,
    int? order,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LawMaterialEntity(
      id: id ?? this.id,
      lawId: lawId ?? this.lawId,
      content: content ?? this.content,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
