import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/question_count_cubit.dart';
import '../cubit/question_count_state.dart';

class QuestionCountPopup extends StatelessWidget {
  final String subjectId;
  final Function(int questionCount, bool considerTime) onStart;

  const QuestionCountPopup({
    Key? key,
    required this.subjectId,
    required this.onStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionCountCubit, QuestionCountState>(
      listener: (context, state) {
        if (state is QuestionCountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        
        title: const Text(
          'Start Quiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        content: BlocBuilder<QuestionCountCubit, QuestionCountState>(
          builder: (context, state) {
            if (state is QuestionCountLoading) {
              return const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is QuestionCountError) {
              return SizedBox(
                height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is QuestionCountLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select number of questions:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.questionOptions.map((count) {
                      final isSelected = state.selectedCount == count;
                      return ChoiceChip(
                        label: Text('$count'),
                        selected: isSelected,
                        onSelected: (_) {
                          context
                              .read<QuestionCountCubit>()
                              .selectQuestionCount(count);
                        },
                        selectedColor: AppColors.primary.withOpacity(0.2),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.secondaryText,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: state.considerTime,
                        onChanged: (value) {
                          context
                              .read<QuestionCountCubit>()
                              .toggleConsiderTime(value ?? false);
                        },
                        activeColor: AppColors.primary,
                      ),
                      const Text(
                        'Consider Time',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          BlocBuilder<QuestionCountCubit, QuestionCountState>(
            builder: (context, state) {
              if (state is QuestionCountLoaded) {
                return ElevatedButton(
                  onPressed: state.selectedCount == null
                      ? null
                      : () {
                          onStart(
                            state.selectedCount!,
                            state.considerTime,
                          );
                          Navigator.of(context).pop();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: const Text('Start Quiz'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

