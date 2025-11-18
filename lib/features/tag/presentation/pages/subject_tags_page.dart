import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/tag_cubit.dart';
import '../cubit/tag_state.dart';

class SubjectTagsPage extends StatelessWidget {
  final String? parentTagId;
  final String? parentTagName;

  const SubjectTagsPage({
    Key? key,
    this.parentTagId,
    this.parentTagName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TagCubit>()..fetchSubjectTags(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(parentTagName != null ? 'Select Subject - $parentTagName' : 'Select Subject'),
        ),
        body: BlocBuilder<TagCubit, TagState>(
          builder: (context, state) {
            if (state is TagLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TagError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<TagCubit>().fetchSubjectTags(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is TagLoaded) {
              if (state.tags.isEmpty) {
                return const Center(child: Text('No subjects available'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.tags.length,
                itemBuilder: (context, index) {
                  final tag = state.tags[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(tag.name),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to sub-tags page
                        // If parentTagId exists (e.g., from PYQ), pass both tags
                        context.push('/sub-tags/${tag.id}', extra: {
                          'tagName': tag.name,
                          'tagId': tag.id,
                          'parentTagId': parentTagId,
                          'parentTagName': parentTagName,
                        });
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

