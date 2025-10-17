import '../entities/quiz.dart';
import '../repositories/quiz_repository.dart';

class GetAvailableQuizzes {
  final QuizRepository repository;

  GetAvailableQuizzes(this.repository);

  Future<List<Quiz>> call() async {
    return await repository.getAvailableQuizzes();
  }
} 