import 'package:agni_pariksha/core/constants/api_constants.dart';
import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:agni_pariksha/features/auth/presentation/cubit/auth_state.dart';
import 'package:agni_pariksha/features/tag/domain/entities/tag.dart';
import 'package:agni_pariksha/features/tag/presentation/cubit/tag_cubit.dart';
import 'package:agni_pariksha/features/tag/presentation/cubit/tag_state.dart';
import 'package:agni_pariksha/injection_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<TagCubit>()..loadTagsByType(TagType.main),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Greeting text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Text(
                        "Hi, ${state.user.fullName}!",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryText,
                        ),
                      );
                    }
                    return Text("Not logged in");
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Static Carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      'Banner 1',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      'Banner 2',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      'Banner 3',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Main Tags Section - 3x3 Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Categories',
                  //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(height: 12),
                  BlocBuilder<TagCubit, TagState>(
                    builder: (context, tagState) {
                      if (tagState is TagLoading || tagState is TagInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (tagState is TagsLoaded) {
                        // Add "Subject" tag to the list
                        final allTags = [
                          ...tagState.tags,
                          Tag(
                            id: 'subject-tag',
                            name: 'Subject',
                            type: TagType.subject,
                            isActive: true,
                            isHierarchical: true,
                            hierarchicalType: TagHierarchicalType.subject,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        ];

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.85,
                              ),
                          itemCount: allTags.length,
                          itemBuilder: (context, index) {
                            final tag = allTags[index];
                            return InkWell(
                              onTap: () {
                                if (tag.isHierarchical) {
                                  if (tag.hierarchicalType ==
                                      TagHierarchicalType.subject) {
                                    context.push('/subject-tags');
                                  } else if (tag.hierarchicalType ==
                                      TagHierarchicalType.subtag) {
                                    context.push(
                                      '/sub-tags/${tag.id}',
                                      extra: {'tagName': tag.name},
                                    );
                                  }
                                } else {
                                  //Open modal for start Quiz logic
                                  //show scaffold message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('On click Quiz will start'),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: tag.image != null
                                          ? Image.network(
                                              '${ApiConstants.baseUrl}/uploads/${tag.image}',
                                              fit: BoxFit.contain,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/ncert.png',
                                                      fit: BoxFit.contain,
                                                    );
                                                  },
                                            )
                                          : Image.asset(
                                              'assets/images/ncert.png',
                                              fit: BoxFit.contain,
                                            ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Text(
                                        tag.name,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (tagState is TagError) {
                        return Center(
                          child: Text('Error: ${tagState.message}'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Subject Option
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
          ],
        ),
      ),
    );
  }
}
