import '../entities/quiz.dart';
import '../repositories/quiz_repository.dart';

class SaveQuizResult {
  final QuizRepository repository;

  SaveQuizResult(this.repository);

  Future<void> call(QuizResult result) async {
    await repository.saveQuizResult(result);
  }
} 