import '../../domain/entities/quiz.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../data_sources/quiz_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource dataSource;

  QuizRepositoryImpl(this.dataSource);

  @override
  Future<List<Quiz>> getAvailableQuizzes() async {
    try {
      final quizModels = await dataSource.getAvailableQuizzes();
      return quizModels;
    } catch (e) {
      throw Exception('Failed to load quizzes: $e');
    }
  }

  @override
  Future<List<Question>> getQuizQuestions(String quizId) async {
    try {
      final questionModels = await dataSource.getQuizQuestions(quizId);
      return questionModels;
    } catch (e) {
      throw Exception('Failed to load quiz questions: $e');
    }
  }

  @override
  Future<void> saveQuizResult(QuizResult result) async {
    // In a real app, this would save to a database or API
    // For now, we'll just simulate a delay
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<List<QuizResult>> getQuizHistory() async {
    // In a real app, this would fetch from a database or API
    // For now, return an empty list
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }
} 