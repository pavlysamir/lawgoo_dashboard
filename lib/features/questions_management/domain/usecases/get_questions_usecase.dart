import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../repositories/questions_repository.dart';

class GetQuestionsUseCase implements UseCase<List<Question>, String?> {
  final QuestionsRepository repository;

  GetQuestionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Question>>> call(String? lawId) async {
    return await repository.getQuestions(lawId: lawId);
  }
}
