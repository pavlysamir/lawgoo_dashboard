import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/questions_repository.dart';

class ToggleQuestionStatusUseCase implements UseCase<void, ToggleQuestionParams> {
  final QuestionsRepository repository;

  ToggleQuestionStatusUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleQuestionParams params) async {
    return await repository.updateQuestionStatus(params.questionId, params.isActive);
  }
}

class ToggleQuestionParams {
  final String questionId;
  final bool isActive;

  ToggleQuestionParams({required this.questionId, required this.isActive});
}
