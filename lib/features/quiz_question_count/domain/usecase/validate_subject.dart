import 'package:agni_pariksha/utils/typedef.dart';
import '../repositories/question_count_repository.dart';

class ValidateSubjectUsecase {
  final QuestionCountRepository repository;

  ValidateSubjectUsecase(this.repository);

  ResultFuture<bool> call(ValidateSubjectParams params) async {
    return await repository.validateSubject(params.subjectId);
  }
}

class ValidateSubjectParams {
  final String subjectId;

  ValidateSubjectParams({required this.subjectId});
}

