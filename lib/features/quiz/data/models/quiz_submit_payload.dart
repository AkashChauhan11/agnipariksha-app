class QuizSubmitPayload {
  final String subjectId;
  final int questionCount;
  final Map<int, int?> answers;
  final Duration totalTime;
  final bool considerTime;

  QuizSubmitPayload({
    required this.subjectId,
    required this.questionCount,
    required this.answers,
    required this.totalTime,
    required this.considerTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'questionCount': questionCount,
      'answers': answers.map((key, value) => MapEntry(key.toString(), value)),
      'totalTime': totalTime.inSeconds,
      'considerTime': considerTime,
    };
  }
}

