import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/answer.dart';

part 'answer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnswerModel extends Answer {
  const AnswerModel({
    required super.text,
    required super.isCorrect,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);

  factory AnswerModel.fromEntity(Answer answer) {
    return AnswerModel(
      text: answer.text,
      isCorrect: answer.isCorrect,
    );
  }
}
