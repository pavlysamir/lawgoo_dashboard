import 'package:equatable/equatable.dart';

class LawMaterialEntity extends Equatable {
  final String id;
  final String lawId;
  final String content;
  final int order;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LawMaterialEntity({
    required this.id,
    required this.lawId,
    required this.content,
    required this.order,
    this.title = '',
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, lawId, content, order, title, createdAt, updatedAt];

  LawMaterialEntity copyWith({
    String? id,
    String? lawId,
    String? content,
    int? order,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LawMaterialEntity(
      id: id ?? this.id,
      lawId: lawId ?? this.lawId,
      content: content ?? this.content,
      order: order ?? this.order,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
