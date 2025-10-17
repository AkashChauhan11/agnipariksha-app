import '../entities/quiz.dart';
import '../repositories/quiz_repository.dart';

class GetQuizQuestions {
  final QuizRepository repository;

  GetQuizQuestions(this.repository);

  Future<List<Question>> call(String quizId) async {
    return await repository.getQuizQuestions(quizId);
  }
} 