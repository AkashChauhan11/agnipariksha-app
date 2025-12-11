import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String text;
  final List<Option> options;

  const Question({
    required this.text,
    required this.options,
  });

  @override
  List<Object?> get props => [text, options];
}

class Option extends Equatable {
  final String text;
  final bool isCorrect;

  const Option({
    required this.text,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [text, isCorrect];
}

