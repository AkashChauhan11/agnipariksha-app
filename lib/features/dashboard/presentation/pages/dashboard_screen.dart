import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../../domain/usecases/get_dashboard_data.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../data/data_sources/dashboard_remote_data_source.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_grid.dart';
import '../../../../main.dart';
import 'home_page.dart';
import 'quiz_page.dart';
import 'profile_page.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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