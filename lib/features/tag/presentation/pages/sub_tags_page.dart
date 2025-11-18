import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tag_cubit.dart';
import '../cubit/tag_state.dart';

class SubTagsPage extends StatelessWidget {
  final String tagId;
  final String tagName;
  final String? parentTagId;
  final String? parentTagName;

  const SubTagsPage({
    Key? key,
    required this.tagId,
    required this.tagName,
    this.parentTagId,
    this.parentTagName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<TagCubit>()..fetchSubTagsByTagId(tagId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Sub-Tag - $tagName'),
        ),
        body: BlocBuilder<TagCubit, TagState>(
          builder: (context, state) {
            if (state is SubTagLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SubTagError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<TagCubit>().fetchSubTagsByTagId(tagId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is SubTagLoaded) {
              if (state.subTags.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No sub-tags available'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Proceed with selected tags
                          _proceedWithSelection(context);
                        },
                        child: const Text('Continue without sub-tag'),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.subTags.length,
                      itemBuilder: (context, index) {
                        final subTag = state.subTags[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            title: Text(subTag.name),
                            onTap: () {
                              // Proceed with selected tags and sub-tag
                              _proceedWithSelection(context, subTagId: subTag.id, subTagName: subTag.name);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () => _proceedWithSelection(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Continue without sub-tag'),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _proceedWithSelection(BuildContext context, {String? subTagId, String? subTagName}) {
    // TODO: Navigate to quiz creation/start page with selected tags
    // For now, show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selected Tags'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (parentTagName != null) Text('Main Tag: $parentTagName'),
            Text('Tag: $tagName'),
            if (subTagName != null) Text('Sub-Tag: $subTagName'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

