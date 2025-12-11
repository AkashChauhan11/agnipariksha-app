import '../models/question_model.dart';
import '../models/quiz_submit_payload.dart';

abstract class QuizRemoteDataSource {
  Future<List<QuestionModel>> getQuestions(int count);
  Future<bool> submitResult(QuizSubmitPayload payload);
}

class FakeQuizApi implements QuizRemoteDataSource {
  @override
  Future<List<QuestionModel>> getQuestions(int count) async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(10, (index) {
      return QuestionModel(
        text: "What is question #$index?",
        options: [
          OptionModel(text: "Option A", isCorrect: false),
          OptionModel(text: "Option B", isCorrect: index % 2 == 0),
          OptionModel(text: "Option C", isCorrect: false),
          OptionModel(text: "Option D", isCorrect: false),
        ],
      );
    });
  }

  @override
  Future<bool> submitResult(QuizSubmitPayload payload) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}

