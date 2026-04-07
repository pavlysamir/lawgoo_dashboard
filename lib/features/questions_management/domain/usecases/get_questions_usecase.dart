import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/question.dart';
import '../repositories/questions_repository.dart';

class GetQuestionsUseCase implements UseCase<List<Question>, NoParams> {
  final QuestionsRepository repository;

  GetQuestionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Question>>> call(NoParams params) async {
    return await repository.getQuestions();
  }
}
