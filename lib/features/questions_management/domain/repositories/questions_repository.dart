import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/question.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, void>> addQuestion(Question question);
  Future<Either<Failure, List<Question>>> getQuestions({String? lawId});
  Future<Either<Failure, void>> updateQuestionStatus(String questionId, bool isActive);
  Future<Either<Failure, void>> deleteQuestion(String questionId);
  Future<Either<Failure, void>> shareQuestion(String questionId);
  Future<Either<Failure, void>> updateQuestion(Question question);
}
