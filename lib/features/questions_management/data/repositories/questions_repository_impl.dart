import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/question.dart';
import '../../domain/repositories/questions_repository.dart';
import '../datasources/questions_remote_data_source.dart';
import '../models/question_model.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  final QuestionsRemoteDataSource remoteDataSource;

  QuestionsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> addQuestion(Question question) async {
    try {
      final questionModel = QuestionModel.fromEntity(question);
      await remoteDataSource.addQuestion(questionModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestions() async {
    try {
      final questions = await remoteDataSource.getQuestions();
      return Right(questions);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuestionStatus(String questionId, bool isActive) async {
    try {
      await remoteDataSource.updateQuestionStatus(questionId, isActive);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteQuestion(String questionId) async {
    try {
      await remoteDataSource.deleteQuestion(questionId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> shareQuestion(String questionId) async {
    try {
      await remoteDataSource.shareQuestion(questionId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuestion(Question question) async {
    try {
      final questionModel = QuestionModel.fromEntity(question);
      await remoteDataSource.updateQuestion(questionModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
