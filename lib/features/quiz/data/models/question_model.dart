import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.text,
    required super.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      text: json['text'] as String,
      options: (json['options'] as List)
          .map((opt) => OptionModel.fromJson(opt))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'options': options.map((opt) => (opt as OptionModel).toJson()).toList(),
    };
  }
}

class OptionModel extends Option {
  const OptionModel({
    required super.text,
    required super.isCorrect,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCorrect': isCorrect,
    };
  }
}

