import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quiz.dart';
import '../bloc/quiz_bloc.dart';

class QuizResultsWidget extends StatelessWidget {
  const QuizResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizCompleted) {
          return _buildResultsScreen(context, state.result);
        } else {
          return const Center(
            child: Text('No results available'),
          );
        }
      },
    );
  }

  Widget _buildResultsScreen(BuildContext context, QuizResult result) {
    final score = result.score;
    final isExcellent = score >= 90;
    final isGood = score >= 70;
    final isAverage = score >= 50;

    Color scoreColor;
    String scoreMessage;
    IconData scoreIcon;

    if (isExcellent) {
      scoreColor = Colors.green;
      scoreMessage = 'Excellent!';
      scoreIcon = Icons.star;
    } else if (isGood) {
      scoreColor = Colors.blue;
      scoreMessage = 'Good Job!';
      scoreIcon = Icons.thumb_up;
    } else if (isAverage) {
      scoreColor = Colors.orange;
      scoreMessage = 'Keep Trying!';
      scoreIcon = Icons.sentiment_satisfied;
    } else {
      scoreColor = Colors.red;
      scoreMessage = 'Need Improvement';
      scoreIcon = Icons.sentiment_dissatisfied;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: scoreColor,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Score header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scoreColor,
                    scoreColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    scoreIcon,
                    size: 64,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    scoreMessage,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${score.toInt()}%',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Score',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Statistics cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Performance overview
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
                            Icon(
                              Icons.analytics,
                              color: scoreColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Performance Overview',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.check_circle,
                                title: 'Correct',
                                value: '${result.correctAnswers}',
                                color: Colors.green,
                                total: result.totalQuestions,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.cancel,
                                title: 'Incorrect',
                                value: '${result.wrongAnswers}',
                                color: Colors.red,
                                total: result.totalQuestions,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.timer,
                                title: 'Time Taken',
                                value: '${result.timeTaken ~/ 60}:${(result.timeTaken % 60).toString().padLeft(2, '0')}',
                                color: Colors.blue,
                                subtitle: 'minutes',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.quiz,
                                title: 'Questions',
                                value: '${result.totalQuestions}',
                                color: Colors.purple,
                                subtitle: 'total',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Detailed breakdown
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
                            Icon(
                              Icons.details,
                              color: scoreColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Detailed Breakdown',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildProgressBar(
                          label: 'Accuracy',
                          value: result.correctAnswers,
                          total: result.totalQuestions,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 12),
                        _buildProgressBar(
                          label: 'Completion',
                          value: result.correctAnswers + result.wrongAnswers,
                          total: result.totalQuestions,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 12),
                        _buildProgressBar(
                          label: 'Efficiency',
                          value: result.correctAnswers,
                          total: result.correctAnswers + result.wrongAnswers,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<QuizBloc>().add(ResetQuiz());
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: scoreColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Try Again',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<QuizBloc>().add(ResetQuiz());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scoreColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Back to Quizzes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    int? total,
    String? subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.8),
            ),
          ),
          if (total != null) ...[
            const SizedBox(height: 4),
            Text(
              'of $total',
              style: TextStyle(
                fontSize: 10,
                color: color.withOpacity(0.6),
              ),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: color.withOpacity(0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar({
    required String label,
    required int value,
    required int total,
    required Color color,
  }) {
    final percentage = total > 0 ? value / total : 0.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 