import 'package:equatable/equatable.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/result_data.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {
  const QuizInitial();
}

class QuizLoading extends QuizState {
  const QuizLoading();
}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentIndex;
  final Map<int, int?> answers;
  final Duration elapsed;
  final bool timerEnabled;

  const QuizLoaded({
    required this.questions,
    required this.currentIndex,
    required this.answers,
    required this.elapsed,
    required this.timerEnabled,
  });

  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentIndex,
    Map<int, int?>? answers,
    Duration? elapsed,
    bool? timerEnabled,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      answers: answers ?? this.answers,
      elapsed: elapsed ?? this.elapsed,
      timerEnabled: timerEnabled ?? this.timerEnabled,
    );
  }

  @override
  List<Object?> get props => [
        questions,
        currentIndex,
        answers,
        elapsed,
        timerEnabled,
      ];
}

class QuizSubmitted extends QuizState {
  final ResultData result;

  const QuizSubmitted(this.result);

  @override
  List<Object?> get props => [result];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}

