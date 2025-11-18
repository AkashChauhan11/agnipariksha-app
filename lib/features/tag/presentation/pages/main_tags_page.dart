import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/tag_cubit.dart';
import '../cubit/tag_state.dart';

class MainTagsPage extends StatelessWidget {
  const MainTagsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TagCubit>()..fetchMainTags(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Category'),
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
                      onPressed: () => context.read<TagCubit>().fetchMainTags(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is TagLoaded) {
              if (state.tags.isEmpty) {
                return const Center(child: Text('No tags available'));
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
                        context.push('/sub-tags/${tag.id}', extra: {
                          'tagName': tag.name,
                          'tagId': tag.id,
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

