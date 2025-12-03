import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/features/tag/domain/entities/tag.dart';
import 'package:agni_pariksha/features/tag/presentation/cubit/tag_cubit.dart';
import 'package:agni_pariksha/features/tag/presentation/cubit/tag_state.dart';
import 'package:agni_pariksha/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubjectTagListPage extends StatelessWidget {
  const SubjectTagListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<TagCubit>()..loadTagsByType(TagType.subject),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Subject'),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<TagCubit, TagState>(
          builder: (context, state) {
            if (state is TagLoading || state is TagInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TagsLoaded) {
              if (state.tags.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: AppColors.secondaryText,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No subjects available',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.tags.length,
                itemBuilder: (context, index) {
                  final tag = state.tags[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.book, color: AppColors.primary),
                      ),
                      title: Text(
                        tag.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        'Subject',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 14,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      onTap: () {
                        // Navigate to sub-tags for this subject
                        context.push(
                          '/sub-tags/${tag.id}',
                          extra: {'tagName': tag.name},
                        );
                      },
                    ),
                  );
                },
              );
            }

            if (state is TagError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.secondaryText),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TagCubit>().loadTagsByType(
                          TagType.subject,
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
