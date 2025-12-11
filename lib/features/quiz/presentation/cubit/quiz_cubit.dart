import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/quiz_remote_data_source.dart';
import '../../data/models/quiz_submit_payload.dart';
import '../../domain/entities/result_data.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRemoteDataSource api;
  Timer? _timer;
  bool timerEnabled = false;
  String? subjectId;

  QuizCubit({required this.api}) : super(const QuizInitial());

  Future<void> startQuiz({
    required String subjectId,
    required int count,
    required bool timerEnabled,
  }) async {
    this.timerEnabled = timerEnabled;
    this.subjectId = subjectId;
    emit(const QuizLoading());

    try {
      final questions = await api.getQuestions(count);

      emit(QuizLoaded(
        questions: questions,
        currentIndex: 0,
        answers: {},
        elapsed: Duration.zero,
        timerEnabled: timerEnabled,
      ));

      if (timerEnabled) {
        startTimer();
      }
    } catch (e) {
      emit(QuizError('Failed to load questions: ${e.toString()}'));
    }
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state is QuizLoaded) {
        final s = state as QuizLoaded;
        emit(s.copyWith(elapsed: s.elapsed + const Duration(seconds: 1)));
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void selectAnswer(int optionIndex) {
    if (state is QuizLoaded) {
      final s = state as QuizLoaded;
      final newAnswers = Map<int, int?>.from(s.answers);
      newAnswers[s.currentIndex] = optionIndex;
      emit(s.copyWith(answers: newAnswers));
    }
  }

  void next() {
    if (state is QuizLoaded) {
      final s = state as QuizLoaded;
      if (s.currentIndex < s.questions.length - 1) {
        emit(s.copyWith(currentIndex: s.currentIndex + 1));
      }
    }
  }

  void previous() {
    if (state is QuizLoaded) {
      final s = state as QuizLoaded;
      if (s.currentIndex > 0) {
        emit(s.copyWith(currentIndex: s.currentIndex - 1));
      }
    }
  }

  void goToQuestion(int index) {
    if (state is QuizLoaded) {
      final s = state as QuizLoaded;
      if (index >= 0 && index < s.questions.length) {
        emit(s.copyWith(currentIndex: index));
      }
    }
  }

  Future<void> submitQuiz() async {
    if (state is! QuizLoaded) return;

    stopTimer();

    final s = state as QuizLoaded;
    final result = _calculateResult(s);

    // Submit to API
    try {
      if (subjectId != null) {
        await api.submitResult(
          QuizSubmitPayload(
            subjectId: subjectId!,
            questionCount: s.questions.length,
            answers: s.answers,
            totalTime: s.elapsed,
            considerTime: timerEnabled,
          ),
        );
      }
      emit(QuizSubmitted(result));
    } catch (e) {
      // Even if submission fails, show result
      emit(QuizSubmitted(result));
    }
  }

  ResultData _calculateResult(QuizLoaded s) {
    int correct = 0, wrong = 0, skipped = 0;

    for (int i = 0; i < s.questions.length; i++) {
      final q = s.questions[i];
      final ans = s.answers[i];

      if (ans == null) {
        skipped++;
      } else if (q.options[ans].isCorrect) {
        correct++;
      } else {
        wrong++;
      }
    }

    return ResultData(
      correct: correct,
      wrong: wrong,
      skipped: skipped,
      totalTime: s.elapsed,
      avgTime: s.questions.isEmpty
          ? Duration.zero
          : Duration(seconds: s.elapsed.inSeconds ~/ s.questions.length),
    );
  }

  @override
  Future<void> close() {
    stopTimer();
    return super.close();
  }
}

