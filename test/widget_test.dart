// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agni_pariksha/main.dart';
import 'package:agni_pariksha/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:agni_pariksha/features/dashboard/presentation/bloc/quiz_bloc.dart';
import 'package:agni_pariksha/features/dashboard/domain/usecases/get_dashboard_data.dart';
import 'package:agni_pariksha/features/dashboard/domain/usecases/get_available_quizzes.dart';
import 'package:agni_pariksha/features/dashboard/domain/usecases/get_quiz_questions.dart';
import 'package:agni_pariksha/features/dashboard/domain/usecases/save_quiz_result.dart';
import 'package:agni_pariksha/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:agni_pariksha/features/dashboard/data/repositories/quiz_repository_impl.dart';
import 'package:agni_pariksha/features/dashboard/data/data_sources/dashboard_remote_data_source.dart';
import 'package:agni_pariksha/features/dashboard/data/data_sources/quiz_data_source.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              GetDashboardData(
                DashboardRepositoryImpl(
                  remoteDataSource: DashboardRemoteDataSource(),
                ),
              ),
            ),
          ),
          BlocProvider<QuizBloc>(
            create: (context) => QuizBloc(
              getAvailableQuizzes: GetAvailableQuizzes(
                QuizRepositoryImpl(
                  QuizDataSourceImpl(),
                ),
              ),
              getQuizQuestions: GetQuizQuestions(
                QuizRepositoryImpl(
                  QuizDataSourceImpl(),
                ),
              ),
              saveQuizResult: SaveQuizResult(
                QuizRepositoryImpl(
                  QuizDataSourceImpl(),
                ),
              ),
            ),
          ),
        ],
        child: ThemeSwitcher(
          child: const MyApp(),
        ),
      ),
    );

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    expect(find.byType(ThemeSwitcher), findsOneWidget);
  });
}
