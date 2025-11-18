import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_grid.dart';
import '../../../tag/presentation/cubit/tag_cubit.dart';
import '../../../tag/presentation/cubit/tag_state.dart';

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
                      BlocBuilder<TagCubit, TagState>(
                        builder: (context, tagState) {
                          if (tagState is TagLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (tagState is TagLoaded) {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: tagState.tags.map((tag) {
                                return Card(
                                  child: InkWell(
                                    onTap: () {
                                      // Check if it's PYQ tag
                                      if (tag.name.toLowerCase() == 'pyq') {
                                        // Navigate to subject list first
                                        context.push('/subject-tags', extra: {
                                          'parentTagId': tag.id,
                                          'parentTagName': tag.name,
                                        });
                                      } else {
                                        // Navigate directly to sub-tags
                                        context.push('/sub-tags/${tag.id}', extra: {
                                          'tagName': tag.name,
                                          'tagId': tag.id,
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      child: Text(tag.name),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          } else if (tagState is TagError) {
                            return Text('Error: ${tagState.message}');
                          }
                          return const SizedBox.shrink();
                        },
                      ),
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
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Create Your Own Quiz',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
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