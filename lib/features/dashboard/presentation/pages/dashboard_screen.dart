import 'package:agni_pariksha/core/services/storage_service.dart';
import 'package:agni_pariksha/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dashboard_bloc.dart';
import '../../domain/usecases/get_dashboard_data.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../data/data_sources/dashboard_remote_data_source.dart';
import '../../../../injection_container.dart' as di;
import 'home_page.dart';
import 'quiz_page.dart';
import 'profile_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    // Check authentication status (validates token with backend)
    // Note: AuthCubit should be provided at app level
    // For now, we'll check storage directly but ideally should use AuthCubit
    final storageService = di.sl<StorageService>();
    final isLoggedIn = await storageService.isLoggedIn();
    final accessToken = await storageService.getAccessToken();
    final isAuthenticated = isLoggedIn && accessToken != null && accessToken.isNotEmpty;

    if (!isAuthenticated) {
      // User is not authenticated, redirect to login
      if (mounted) {
        context.go(RouteNames.login);
      }
    }
  }

  static final List<Widget> _pages = [
    HomePage(),
    QuizPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc(
        GetDashboardData(
          DashboardRepositoryImpl(
            remoteDataSource: DashboardRemoteDataSource(),
          ),
        ),
      )..add(FetchDashboardData()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is DashboardLoaded) {
            currentIndex = state.currentPageIndex;
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Quiz Dashboard'),
              centerTitle: true,
           
            ),
            body: _pages[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<DashboardBloc>().add(ChangeDashboardPage(index));
              },
            ),
          );
        },
      ),
    );
  }
} 