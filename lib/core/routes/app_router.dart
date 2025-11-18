import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../../features/tag/presentation/pages/main_tags_page.dart';
import '../../features/tag/presentation/pages/subject_tags_page.dart';
import '../../features/tag/presentation/pages/sub_tags_page.dart';
import '../../features/tag/presentation/pages/create_quiz_page.dart';
import '../services/storage_service.dart';
import 'route_names.dart';

class AppRouter {
  final StorageService storageService;

  AppRouter(this.storageService);

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.otpVerification,
        name: 'otp-verification',
        pageBuilder: (context, state) {
          final email = state.extra as String?;
          return MaterialPage(
            key: state.pageKey,
            child: OtpVerificationPage(
              email: email ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: 'forgot-password',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ForgotPasswordPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        name: 'reset-password',
        pageBuilder: (context, state) {
          final email = state.extra as String?;
          return MaterialPage(
            key: state.pageKey,
            child: ResetPasswordPage(
              email: email ?? '',
            ),
          );
        },
      ),
      GoRoute(
        path: RouteNames.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: RouteNames.mainTags,
        name: 'main-tags',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MainTagsPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.subjectTags,
        name: 'subject-tags',
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return MaterialPage(
            key: state.pageKey,
            child: SubjectTagsPage(
              parentTagId: extra?['parentTagId'] as String?,
              parentTagName: extra?['parentTagName'] as String?,
            ),
          );
        },
      ),
      GoRoute(
        path: RouteNames.subTags,
        name: 'sub-tags',
        pageBuilder: (context, state) {
          final tagId = state.pathParameters['tagId']!;
          final extra = state.extra as Map<String, dynamic>?;
          return MaterialPage(
            key: state.pageKey,
            child: SubTagsPage(
              tagId: tagId,
              tagName: extra?['tagName'] as String? ?? 'Tag',
              parentTagId: extra?['parentTagId'] as String?,
              parentTagName: extra?['parentTagName'] as String?,
            ),
          );
        },
      ),
      GoRoute(
        path: RouteNames.createQuiz,
        name: 'create-quiz',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CreateQuizPage(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(state.error?.toString() ?? 'Unknown error'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(RouteNames.dashboard),
                child: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

