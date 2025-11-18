import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tag_cubit.dart';
import '../cubit/tag_state.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/sub_tag.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({Key? key}) : super(key: key);

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  Tag? selectedTag;
  SubTag? selectedSubTag;
  List<Tag> allTags = [];
  List<SubTag> subTags = [];

  @override
  void initState() {
    super.initState();
    context.read<TagCubit>().fetchAllTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Own Quiz'),
      ),
      body: BlocConsumer<TagCubit, TagState>(
        listener: (context, state) {
          if (state is TagLoaded) {
            setState(() {
              allTags = state.tags;
            });
          } else if (state is SubTagLoaded) {
            setState(() {
              subTags = state.subTags;
            });
          }
        },
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
                    onPressed: () => context.read<TagCubit>().fetchAllTags(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Tag Selection
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Tag',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (allTags.isEmpty)
                          const Text('No tags available')
                        else
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: allTags.map((tag) {
                              final isSelected = selectedTag?.id == tag.id;
                              return FilterChip(
                                label: Text(tag.name),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedTag = tag;
                                      selectedSubTag = null;
                                      subTags = [];
                                      context.read<TagCubit>().fetchSubTagsByTagId(tag.id);
                                    } else {
                                      selectedTag = null;
                                      selectedSubTag = null;
                                      subTags = [];
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sub-Tag Selection (only if tag is selected)
                if (selectedTag != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Sub-Tag (${selectedTag!.name})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (state is SubTagLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (subTags.isEmpty)
                            const Text('No sub-tags available for this tag')
                          else
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: subTags.map((subTag) {
                                final isSelected = selectedSubTag?.id == subTag.id;
                                return FilterChip(
                                  label: Text(subTag.name),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setState(() {
                                      selectedSubTag = selected ? subTag : null;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // Create Quiz Button
                ElevatedButton(
                  onPressed: selectedTag != null
                      ? () {
                          // TODO: Navigate to quiz creation with selected tags
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Create Quiz'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tag: ${selectedTag!.name}'),
                                  if (selectedSubTag != null)
                                    Text('Sub-Tag: ${selectedSubTag!.name}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // TODO: Create quiz
                                  },
                                  child: const Text('Create'),
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Create Quiz'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

