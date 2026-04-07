import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../repositories/questions_repository.dart';

class AddQuestionUseCase implements UseCase<void, Question> {
  final QuestionsRepository repository;

  AddQuestionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Question question) async {
    return await repository.addQuestion(question);
  }
}
