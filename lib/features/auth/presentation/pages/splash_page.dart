import 'package:agni_pariksha/core/routes/route_names.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
       if (!mounted) return;
      context.read<AuthCubit>().checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (ctx, state) {
        if (state is Authenticated) {
          // User is authenticated, navigate to dashboard
          if (mounted) {
            ctx.go(RouteNames.dashboard);
          }
        } else if (state is Unauthenticated) {
          // User is not authenticated, navigate to login
          if (mounted) {
            ctx.go(RouteNames.login);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_fire_department, size: 100, color: Colors.red),
              const SizedBox(height: 24),
              Text(
                'Agni Pariksha',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your Learning Companion',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
