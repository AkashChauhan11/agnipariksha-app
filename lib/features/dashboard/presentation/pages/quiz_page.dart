import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../widgets/quiz_list_widget.dart';
import '../widgets/quiz_interface_widget.dart';
import '../widgets/quiz_results_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    // Load quizzes when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizBloc>().add(LoadQuizzes());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading quizzes...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is QuizListLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Quiz Section',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            body: const QuizListWidget(),
          );
        } else if (state is QuizStarted) {
          return const QuizInterfaceWidget();
        } else if (state is QuizCompleted) {
          return const QuizResultsWidget();
        } else if (state is QuizError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz Section'),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<QuizBloc>().add(LoadQuizzes());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz Section'),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
            ),
            body: const Center(
              child: Text('Welcome to Quiz Section'),
            ),
          );
        }
      },
    );
  }
} 