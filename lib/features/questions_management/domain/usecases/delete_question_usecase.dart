import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/questions_repository.dart';

class DeleteQuestionUseCase implements UseCase<void, String> {
  final QuestionsRepository repository;

  DeleteQuestionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String questionId) async {
    return await repository.deleteQuestion(questionId);
  }
}
