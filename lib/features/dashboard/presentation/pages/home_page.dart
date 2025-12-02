import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is Authenticated) {
                          return Text(
                            "Hi, ${state.user.fullName}!",
                            
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600 , color: AppColors.secondaryText),
                          );
                        }
                        return Text("Not logged in");
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                BannerCarousel(banners: state.dashboard.banners),
                const SizedBox(height: 24),

                // Main Tags Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Categories'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Subject Option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.push('/subject-tags');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.subject),
                            const SizedBox(width: 12),
                            Text(
                              'Subject',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Create Your Own Quiz Option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: InkWell(
                      onTap: () {
                        context.push('/create-quiz');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Create Your Own Quiz',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
