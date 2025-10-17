import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DashboardLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Greeting text above carousel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hi, User!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                BannerCarousel(banners: state.dashboard.banners),
                const SizedBox(height: 24),
                CategoryGrid(categories: state.dashboard.categories),
              ],
            ),
          );
        } else if (state is DashboardError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
} 