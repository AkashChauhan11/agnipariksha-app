import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quiz.dart';
import '../../domain/usecases/get_available_quizzes.dart';
import '../../domain/usecases/get_quiz_questions.dart';
import '../../domain/usecases/save_quiz_result.dart';

// Events
abstract class QuizEvent {}

class LoadQuizzes extends QuizEvent {}

class StartQuiz extends QuizEvent {
  final Quiz quiz;
  StartQuiz(this.quiz);
}

class AnswerQuestion extends QuizEvent {
  final int questionIndex;
  final int selectedAnswerIndex;
  final int timeSpent;
  AnswerQuestion(this.questionIndex, this.selectedAnswerIndex, this.timeSpent);
}

class NextQuestion extends QuizEvent {}

class PreviousQuestion extends QuizEvent {}

class FinishQuiz extends QuizEvent {}

class ResetQuiz extends QuizEvent {}

// States
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizListLoaded extends QuizState {
  final List<Quiz> quizzes;
  QuizListLoaded(this.quizzes);
}

class QuizStarted extends QuizState {
  final Quiz quiz;
  final List<Question> questions;
  final int currentQuestionIndex;
  final List<int?> answers;
  final List<int> timeSpent;
  final int totalTimeElapsed;
  final Timer? timer;

  QuizStarted({
    required this.quiz,
    required this.questions,
    required this.currentQuestionIndex,
    required this.answers,
    required this.timeSpent,
    required this.totalTimeElapsed,
    this.timer,
  });

  QuizStarted copyWith({
    Quiz? quiz,
    List<Question>? questions,
    int? currentQuestionIndex,
    List<int?>? answers,
    List<int>? timeSpent,
    int? totalTimeElapsed,
    Timer? timer,
  }) {
    return QuizStarted(
      quiz: quiz ?? this.quiz,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answers: answers ?? this.answers,
      timeSpent: timeSpent ?? this.timeSpent,
      totalTimeElapsed: totalTimeElapsed ?? this.totalTimeElapsed,
      timer: timer ?? this.timer,
    );
  }
}

class QuizCompleted extends QuizState {
  final QuizResult result;
  QuizCompleted(this.result);
}

class QuizError extends QuizState {
  final String message;
  QuizError(this.message);
}

// Bloc
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetAvailableQuizzes getAvailableQuizzes;
  final GetQuizQuestions getQuizQuestions;
  final SaveQuizResult saveQuizResult;

  QuizBloc({
    required this.getAvailableQuizzes,
    required this.getQuizQuestions,
    required this.saveQuizResult,
  }) : super(QuizInitial()) {
    on<LoadQuizzes>(_onLoadQuizzes);
    on<StartQuiz>(_onStartQuiz);
    on<AnswerQuestion>(_onAnswerQuestion);
    on<NextQuestion>(_onNextQuestion);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<FinishQuiz>(_onFinishQuiz);
    on<ResetQuiz>(_onResetQuiz);
  }

  Future<void> _onLoadQuizzes(LoadQuizzes event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      final quizzes = await getAvailableQuizzes();
      emit(QuizListLoaded(quizzes));
    } catch (e) {
      emit(QuizError('Failed to load quizzes: $e'));
    }
  }

  Future<void> _onStartQuiz(StartQuiz event, Emitter<QuizState> emit) async {
    emit(QuizLoading());
    try {
      final questions = await getQuizQuestions(event.quiz.id);
      final answers = List<int?>.filled(questions.length, null);
      final timeSpent = List<int>.filled(questions.length, 0);
      
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (state is QuizStarted) {
          final currentState = state as QuizStarted;
          emit(currentState.copyWith(
            totalTimeElapsed: currentState.totalTimeElapsed + 1,
          ));
        }
      });

      emit(QuizStarted(
        quiz: event.quiz,
        questions: questions,
        currentQuestionIndex: 0,
        answers: answers,
        timeSpent: timeSpent,
        totalTimeElapsed: 0,
        timer: timer,
      ));
    } catch (e) {
      emit(QuizError('Failed to start quiz: $e'));
    }
  }

  void _onAnswerQuestion(AnswerQuestion event, Emitter<QuizState> emit) {
    if (state is QuizStarted) {
      final currentState = state as QuizStarted;
      final newAnswers = List<int?>.from(currentState.answers);
      final newTimeSpent = List<int>.from(currentState.timeSpent);
      
      newAnswers[event.questionIndex] = event.selectedAnswerIndex;
      newTimeSpent[event.questionIndex] = event.timeSpent;
      
      emit(currentState.copyWith(
        answers: newAnswers,
        timeSpent: newTimeSpent,
      ));
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (state is QuizStarted) {
      final currentState = state as QuizStarted;
      if (currentState.currentQuestionIndex < currentState.questions.length - 1) {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
        ));
      }
    }
  }

  void _onPreviousQuestion(PreviousQuestion event, Emitter<QuizState> emit) {
    if (state is QuizStarted) {
      final currentState = state as QuizStarted;
      if (currentState.currentQuestionIndex > 0) {
        emit(currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex - 1,
        ));
      }
    }
  }

  Future<void> _onFinishQuiz(FinishQuiz event, Emitter<QuizState> emit) async {
    if (state is QuizStarted) {
      final currentState = state as QuizStarted;
      currentState.timer?.cancel();
      
      // Calculate results
      int correctAnswers = 0;
      int wrongAnswers = 0;
      final questionResults = <QuestionResult>[];
      
      for (int i = 0; i < currentState.questions.length; i++) {
        final question = currentState.questions[i];
        final selectedAnswer = currentState.answers[i];
        
        if (selectedAnswer != null) {
          final isCorrect = selectedAnswer == question.correctAnswerIndex;
          if (isCorrect) {
            correctAnswers++;
          } else {
            wrongAnswers++;
          }
          
          questionResults.add(QuestionResult(
            questionId: question.id,
            selectedAnswerIndex: selectedAnswer,
            correctAnswerIndex: question.correctAnswerIndex,
            isCorrect: isCorrect,
            timeSpent: currentState.timeSpent[i],
          ));
        }
      }
      
      final score = (correctAnswers / currentState.questions.length) * 100;
      
      final result = QuizResult(
        quizId: currentState.quiz.id,
        totalQuestions: currentState.questions.length,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        timeTaken: currentState.totalTimeElapsed,
        score: score,
        completedAt: DateTime.now(),
        questionResults: questionResults,
      );
      
      try {
        await saveQuizResult(result);
        emit(QuizCompleted(result));
      } catch (e) {
        emit(QuizError('Failed to save quiz result: $e'));
      }
    }
  }

  void _onResetQuiz(ResetQuiz event, Emitter<QuizState> emit) {
    if (state is QuizStarted) {
      final currentState = state as QuizStarted;
      currentState.timer?.cancel();
    }
    emit(QuizInitial());
  }

  @override
  Future<void> close() {
    if (state is QuizStarted) {
      final currentState = state as QuizStarted;
      currentState.timer?.cancel();
    }
    return super.close();
  }
} 