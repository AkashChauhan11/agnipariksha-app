import '../../domain/entities/quiz.dart';

class QuizModel extends Quiz {
  QuizModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.totalQuestions,
    required super.timeLimit,
    required super.imageUrl,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      totalQuestions: json['totalQuestions'],
      timeLimit: json['timeLimit'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'totalQuestions': totalQuestions,
      'timeLimit': timeLimit,
      'imageUrl': imageUrl,
    };
  }
}

class QuestionModel extends Question {
  QuestionModel({
    required super.id,
    required super.questionText,
    required super.options,
    required super.correctAnswerIndex,
    required super.explanation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
    };
  }
}

class QuizResultModel extends QuizResult {
  QuizResultModel({
    required super.quizId,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.wrongAnswers,
    required super.timeTaken,
    required super.score,
    required super.completedAt,
    required super.questionResults,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      quizId: json['quizId'],
      totalQuestions: json['totalQuestions'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      timeTaken: json['timeTaken'],
      score: json['score'].toDouble(),
      completedAt: DateTime.parse(json['completedAt']),
      questionResults: (json['questionResults'] as List)
          .map((result) => QuestionResultModel.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'timeTaken': timeTaken,
      'score': score,
      'completedAt': completedAt.toIso8601String(),
      'questionResults': questionResults
          .map((result) => (result as QuestionResultModel).toJson())
          .toList(),
    };
  }
}

class QuestionResultModel extends QuestionResult {
  QuestionResultModel({
    required super.questionId,
    required super.selectedAnswerIndex,
    required super.correctAnswerIndex,
    required super.isCorrect,
    required super.timeSpent,
  });

  factory QuestionResultModel.fromJson(Map<String, dynamic> json) {
    return QuestionResultModel(
      questionId: json['questionId'],
      selectedAnswerIndex: json['selectedAnswerIndex'],
      correctAnswerIndex: json['correctAnswerIndex'],
      isCorrect: json['isCorrect'],
      timeSpent: json['timeSpent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedAnswerIndex': selectedAnswerIndex,
      'correctAnswerIndex': correctAnswerIndex,
      'isCorrect': isCorrect,
      'timeSpent': timeSpent,
    };
  }
} 