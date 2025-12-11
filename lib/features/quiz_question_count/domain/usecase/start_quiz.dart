import 'package:agni_pariksha/utils/typedef.dart';
import '../repositories/question_count_repository.dart';

class StartQuizUsecase {
  final QuestionCountRepository repository;

  StartQuizUsecase(this.repository);

  ResultFuture<void> call(StartQuizParams params) async {
    return await repository.startQuiz(
      subjectId: params.subjectId,
      questionCount: params.questionCount,
      considerTime: params.considerTime,
    );
  }
}

class StartQuizParams {
  final String subjectId;
  final int questionCount;
  final bool considerTime;

  StartQuizParams({
    required this.subjectId,
    required this.questionCount,
    required this.considerTime,
  });
}

