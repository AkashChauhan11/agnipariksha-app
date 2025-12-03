import 'package:agni_pariksha/core/theme/colors.dart';
import 'package:agni_pariksha/features/sub_tag/presentation/cubit/sub_tag_cubit.dart';
import 'package:agni_pariksha/features/sub_tag/presentation/cubit/sub_tag_state.dart';
import 'package:agni_pariksha/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubTagListPage extends StatelessWidget {
  final String tagId;
  final String tagName;

  const SubTagListPage({Key? key, required this.tagId, required this.tagName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<SubTagCubit>()..loadSubTagsByTagId(tagId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tagName),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<SubTagCubit, SubTagState>(
          builder: (context, state) {
            if (state is SubTagLoading || state is SubTagInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SubTagsLoaded) {
              if (state.subTags.isEmpty) {
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
                        'No sub-tags available',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.subTags.length,
                itemBuilder: (context, index) {
                  final subTag = state.subTags[index];
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
                        child: Icon(
                          _getIconForSubTagType(subTag.type.toString()),
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(
                        subTag.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        _formatSubTagType(subTag.type.toString()),
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
                        // Handle sub-tag tap - navigate to next level or quiz
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected: ${subTag.name}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }

            if (state is SubTagError) {
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
                        context.read<SubTagCubit>().loadSubTagsByTagId(tagId);
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

  IconData _getIconForSubTagType(String type) {
    if (type.contains('class')) return Icons.class_;
    if (type.contains('year')) return Icons.calendar_today;
    if (type.contains('chapter')) return Icons.book;
    if (type.contains('topic')) return Icons.topic;
    return Icons.label;
  }

  String _formatSubTagType(String type) {
    final cleanType = type.split('.').last.replaceAll('_', ' ');
    return cleanType[0].toUpperCase() + cleanType.substring(1);
  }
}
