import '../../../../core/services/api_service.dart';
import '../../../../core/errors/exceptions.dart';

abstract class QuestionCountRemoteDataSource {
  Future<bool> validateSubject(String subjectId);
  Future<void> startQuiz({
    required String subjectId,
    required int questionCount,
    required bool considerTime,
  });
}

class QuestionCountRemoteDataSourceImpl
    implements QuestionCountRemoteDataSource {
  final ApiService apiService;

  QuestionCountRemoteDataSourceImpl({required this.apiService});

  @override
  Future<bool> validateSubject(String subjectId) async {
    try {
      // Fake API call - simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Fake validation logic - always return true for now
      // In real implementation, this would be:
      // final response = await apiService.get('/subject/validate/$subjectId');
      // return response.data['is_available'] == true;

      return true;
    } catch (e) {
      throw ServerException('Failed to validate subject', 500);
    }
  }

  @override
  Future<void> startQuiz({
    required String subjectId,
    required int questionCount,
    required bool considerTime,
  }) async {
    try {
      // Fake API call - simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Fake quiz start logic
      // In real implementation, this would be:
      // await apiService.post('/quiz/start', data: {
      //   'subject_id': subjectId,
      //   'question_count': questionCount,
      //   'consider_time': considerTime,
      // });

      return;
    } catch (e) {
      throw ServerException('Failed to start quiz', 500);
    }
  }
}

