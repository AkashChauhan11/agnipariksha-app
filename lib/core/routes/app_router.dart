import 'package:agni_pariksha/core/routes/go_router_refresh_stream.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_screen.dart';
import '../services/storage_service.dart';
import 'route_names.dart';

class AppRouter {
  final StorageService storageService;
  final AuthCubit authCubit;

  AppRouter(this.storageService, this.authCubit);

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),

    redirect: (context, state) {
      final authState = authCubit.state;
      final isOnSplashScreen = state.fullPath == RouteNames.splash;
      final isOnLoginPage = state.fullPath == RouteNames.login;
      final isOnDashboard = state.fullPath == RouteNames.dashboard;


      // Handle loading and initial states
      if (authState is AuthInitial || authState is AuthLoading) {
        // Stay on the current screen (which should be the splash screen initially)
        return null;
      }

      // Handle Authenticated state
      if (authState is Authenticated) {
        // If the user is authenticated and they are on the splash or login page,
        // send them to the dashboard.
        if (isOnSplashScreen || isOnLoginPage) {
          return RouteNames.dashboard;
        }
        // Otherwise, they are likely already on the dashboard or another valid page, so stay put.
        return null;
      }

      // Handle Unauthenticated state
      if (authState is Unauthenticated) {
        // If the user is unauthenticated and they are on the splash screen or dashboard,
        // send them to the login page.
        if (isOnSplashScreen || isOnDashboard) {
          return RouteNames.login;
        }
        // Otherwise, they are already on a public page (login, register, forgot password, etc.), so stay put.
        return null;
      }

      // Fallback case
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SplashPage()),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: LoginPage()),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const RegisterPage()),
      ),
      GoRoute(
        path: RouteNames.otpVerification,
        name: 'otp-verification',
        pageBuilder: (context, state) {
          final email = state.extra as String?;
          return MaterialPage(
            key: state.pageKey,
            child: OtpVerificationPage(email: email ?? ''),
          );
        },
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: 'forgot-password',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const ForgotPasswordPage()),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        name: 'reset-password',
        pageBuilder: (context, state) {
          final email = state.extra as String?;
          return MaterialPage(
            key: state.pageKey,
            child: ResetPasswordPage(email: email ?? ''),
          );
        },
      ),
      GoRoute(
        path: RouteNames.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const DashboardScreen()),
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
