import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';

class QuizInterfaceWidget extends StatefulWidget {
  const QuizInterfaceWidget({Key? key}) : super(key: key);

  @override
  State<QuizInterfaceWidget> createState() => _QuizInterfaceWidgetState();
}

class _QuizInterfaceWidgetState extends State<QuizInterfaceWidget> {
  Timer? _questionTimer;
  int _questionTimeElapsed = 0;

  @override
  void initState() {
    super.initState();
    _startQuestionTimer();
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  void _startQuestionTimer() {
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _questionTimeElapsed++;
      });
    });
  }

  void _resetQuestionTimer() {
    _questionTimer?.cancel();
    setState(() {
      _questionTimeElapsed = 0;
    });
    _startQuestionTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizStarted) {
          final question = state.questions[state.currentQuestionIndex];
          final selectedAnswer = state.answers[state.currentQuestionIndex];
          final isLastQuestion = state.currentQuestionIndex == state.questions.length - 1;

          return Scaffold(
            appBar: AppBar(
              title: Text(state.quiz.title),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              elevation: 0,
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.timer, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${state.totalTimeElapsed ~/ 60}:${(state.totalTimeElapsed % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                // Progress bar
                Container(
                  width: double.infinity,
                  height: 4,
                  color: Colors.grey[200],
                  child: LinearProgressIndicator(
                    value: (state.currentQuestionIndex + 1) / state.questions.length,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                  ),
                ),
                
                // Question counter
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${state.currentQuestionIndex + 1} of ${state.questions.length}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '${((state.currentQuestionIndex + 1) / state.questions.length * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Question
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question text
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.quiz,
                                      color: Colors.blue[700],
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      question.questionText,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Options
                        ...question.options.asMap().entries.map((entry) {
                          final index = entry.key;
                          final option = entry.value;
                          final isSelected = selectedAnswer == index;
                          
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () {
                                context.read<QuizBloc>().add(
                                  AnswerQuestion(
                                    state.currentQuestionIndex,
                                    index,
                                    _questionTimeElapsed,
                                  ),
                                );
                                _resetQuestionTimer();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.blue[100] : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected ? Colors.blue[600] : Colors.grey[300],
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          : Text(
                                              String.fromCharCode(65 + index), // A, B, C, D
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                          color: isSelected ? Colors.blue[800] : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                
                // Navigation buttons
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (state.currentQuestionIndex > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<QuizBloc>().add(PreviousQuestion());
                              _resetQuestionTimer();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: Colors.blue[600]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      if (state.currentQuestionIndex > 0) const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLastQuestion
                              ? () {
                                  context.read<QuizBloc>().add(FinishQuiz());
                                }
                              : () {
                                  context.read<QuizBloc>().add(NextQuestion());
                                  _resetQuestionTimer();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isLastQuestion ? 'Finish Quiz' : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Quiz not started'),
          );
        }
      },
    );
  }
} 