import '../entities/quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getAvailableQuizzes();
  Future<List<Question>> getQuizQuestions(String quizId);
  Future<void> saveQuizResult(QuizResult result);
  Future<List<QuizResult>> getQuizHistory();
} 