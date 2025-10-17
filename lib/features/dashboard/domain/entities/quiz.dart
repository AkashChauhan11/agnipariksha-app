class Quiz {
  final String id;
  final String title;
  final String description;
  final String category;
  final int totalQuestions;
  final int timeLimit; // in minutes
  final String imageUrl;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.totalQuestions,
    required this.timeLimit,
    required this.imageUrl,
  });
}

class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class QuizResult {
  final String quizId;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int timeTaken; // in seconds
  final double score; // percentage
  final DateTime completedAt;
  final List<QuestionResult> questionResults;

  QuizResult({
    required this.quizId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.timeTaken,
    required this.score,
    required this.completedAt,
    required this.questionResults,
  });
}

class QuestionResult {
  final String questionId;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;
  final bool isCorrect;
  final int timeSpent; // in seconds

  QuestionResult({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
    required this.isCorrect,
    required this.timeSpent,
  });
} 