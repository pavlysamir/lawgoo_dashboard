import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/question.dart';
import 'answer_model.dart';

part 'question_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class QuestionModel extends Question {
  @override
  final List<AnswerModel> answers;

  const QuestionModel({
    super.questionId,
    required super.lawId,
    required super.materialId,
    required super.level,
    required super.questionText,
    required this.answers, // 👈 هنا
    required super.difficulty,
    required super.type,
    super.isShared = false,
    super.isActive = true,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
    super.createdAt,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeToTimestamp)
    super.updatedAt,
    super.isDeleted = false,
  }) : super(answers: answers);
  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  factory QuestionModel.fromEntity(Question question) {
    return QuestionModel(
      questionId: question.questionId,
      lawId: question.lawId,
      materialId: question.materialId,
      level: question.level,
      questionText: question.questionText,
      answers: question.answers.map((e) => AnswerModel.fromEntity(e)).toList(),
      difficulty: question.difficulty,
      type: question.type,
      isShared: question.isShared,
      isActive: question.isActive,
      createdAt: question.createdAt,
      updatedAt: question.updatedAt,
      isDeleted: question.isDeleted,
    );
  }

  static DateTime? _dateTimeFromTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.tryParse(timestamp);
    if (timestamp is FieldValue) return null; // FieldValue cannot be converted to DateTime
    return null;
  }

  static dynamic _dateTimeToTimestamp(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}
