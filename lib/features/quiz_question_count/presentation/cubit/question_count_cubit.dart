import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/validate_subject.dart';
import '../../domain/usecase/start_quiz.dart';
import 'question_count_state.dart';

class QuestionCountCubit extends Cubit<QuestionCountState> {
  final ValidateSubjectUsecase validateSubjectUsecase;
  final StartQuizUsecase startQuizUsecase;

  QuestionCountCubit({
    required this.validateSubjectUsecase,
    required this.startQuizUsecase,
  }) : super(const QuestionCountInitial());

  // Step 1: Validate API before showing options
  Future<void> validateSubject(String subjectId) async {
    emit(const QuestionCountLoading());

    final result = await validateSubjectUsecase(
      ValidateSubjectParams(subjectId: subjectId),
    );

    result.fold(
      (failure) => emit(QuestionCountError(failure.message)),
      (isValid) {
        if (!isValid) {
          emit(const QuestionCountError('Subject not available'));
          return;
        }

        // Show question count options
        emit(const QuestionCountLoaded(
          questionOptions: [10, 20, 50, 150, 200],
        ));
      },
    );
  }

  // Step 2: Update selected value
  void selectQuestionCount(int value) {
    if (state is QuestionCountLoaded) {
      emit(
        (state as QuestionCountLoaded).copyWith(selectedCount: value),
      );
    }
  }

  // Step 3: Toggle checkbox
  void toggleConsiderTime(bool value) {
    if (state is QuestionCountLoaded) {
      emit(
        (state as QuestionCountLoaded).copyWith(considerTime: value),
      );
    }
  }

  // Step 4: Start quiz
  Future<void> startQuiz({
    required String subjectId,
    required int questionCount,
    required bool considerTime,
  }) async {
    final result = await startQuizUsecase(
      StartQuizParams(
        subjectId: subjectId,
        questionCount: questionCount,
        considerTime: considerTime,
      ),
    );

    result.fold(
      (failure) => emit(QuestionCountError(failure.message)),
      (_) {
        // Quiz started successfully - state will be handled by parent
        // You can emit a success state here if needed
      },
    );
  }
}

