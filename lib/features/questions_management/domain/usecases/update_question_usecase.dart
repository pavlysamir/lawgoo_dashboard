import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../repositories/questions_repository.dart';

class UpdateQuestionUseCase implements UseCase<void, Question> {
  final QuestionsRepository repository;

  UpdateQuestionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Question question) async {
    return await repository.updateQuestion(question);
  }
}
