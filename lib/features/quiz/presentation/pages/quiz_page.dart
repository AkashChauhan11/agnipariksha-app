import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/quiz_cubit.dart';
import '../cubit/quiz_state.dart';

class QuizPage extends StatelessWidget {
  final String subjectId;
  final int questionCount;
  final bool considerTime;

  const QuizPage({
    Key? key,
    required this.subjectId,
    required this.questionCount,
    required this.considerTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuizCubit>()
        ..startQuiz(
          subjectId: subjectId,
          count: questionCount,
          timerEnabled: considerTime,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocConsumer<QuizCubit, QuizState>(
          listener: (context, state) {
            if (state is QuizSubmitted) {
              // Navigate to result page
              context.pushReplacement('/quiz-result', extra: state.result);
            } else if (state is QuizError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is QuizLoaded) {
              return _buildQuizContent(context, state);
            }

            if (state is QuizError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context, QuizLoaded state) {
    final question = state.questions[state.currentIndex];
    final isLastQuestion = state.currentIndex == state.questions.length - 1;
    final isFirstQuestion = state.currentIndex == 0;
    final selectedAnswer = state.answers[state.currentIndex];

    return Column(
      children: [
        // Timer and Progress
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.primary.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (state.timerEnabled)
                Row(
                  children: [
                    const Icon(Icons.timer, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${state.elapsed.inMinutes}:${(state.elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              Text(
                'Question ${state.currentIndex + 1} of ${state.questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // Progress Bar
        LinearProgressIndicator(
          value: (state.currentIndex + 1) / state.questions.length,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),

        // Question and Options
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Number Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Question ${state.currentIndex + 1}',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Question Text
                Text(
                  question.text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Options
                ...List.generate(question.options.length, (index) {
                  final option = question.options[index];
                  final isSelected = selectedAnswer == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected
                          ? AppColors.primary.withOpacity(0.1)
                          : Colors.white,
                    ),
                    child: ListTile(
                      title: Text(
                        option.text,
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.secondaryText,
                        ),
                      ),
                      leading: Radio<int>(
                        value: index,
                        groupValue: selectedAnswer,
                        onChanged: (value) {
                          context.read<QuizCubit>().selectAnswer(index);
                        },
                        activeColor: AppColors.primary,
                      ),
                      onTap: () {
                        context.read<QuizCubit>().selectAnswer(index);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        // Navigation Buttons
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: isFirstQuestion
                    ? null
                    : () => context.read<QuizCubit>().previous(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black87,
                  disabledBackgroundColor: Colors.grey[200],
                ),
              ),
              if (!isLastQuestion)
                ElevatedButton.icon(
                  onPressed: () => context.read<QuizCubit>().next(),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: () => context.read<QuizCubit>().submitQuiz(),
                  icon: const Icon(Icons.check),
                  label: const Text('Submit Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

