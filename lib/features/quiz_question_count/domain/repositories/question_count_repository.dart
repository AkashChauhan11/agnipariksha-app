import 'package:agni_pariksha/utils/typedef.dart';

abstract class QuestionCountRepository {
  ResultFuture<bool> validateSubject(String subjectId);
  ResultFuture<void> startQuiz({
    required String subjectId,
    required int questionCount,
    required bool considerTime,
  });
}

