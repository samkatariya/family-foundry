import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_problem_repository.dart';
import '../../data/models/problem.dart';

final problemDetailProvider =
    FutureProvider.family<Problem?, String>((ref, id) async {
  return MockProblemRepository().getProblemById(id);
});

class ProblemDetailScreen extends ConsumerWidget {
  final String problemId;
  const ProblemDetailScreen({super.key, required this.problemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problemAsync = ref.watch(problemDetailProvider(problemId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Problem')),
      body: problemAsync.when(
        data: (problem) {
          if (problem == null) {
            return const Center(child: Text('Problem not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  problem.title,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Posted by ${problem.postedBy} · ${problem.category}',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
                const Divider(height: 24),
                Text(problem.description, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 24),
                Text(
                  'People interested (${problem.interestedMembers.length})',
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (problem.interestedMembers.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: problem.interestedMembers
                        .map((name) => Chip(
                              avatar: CircleAvatar(child: Text(name[0])),
                              label: Text(name),
                            ))
                        .toList(),
                  )
                else
                  const Text('No one yet. Be the first!'),
                const SizedBox(height: 24),
                Text(
                  'Potential solutions: ${problem.potentialSolutions}',
                  style: theme.textTheme.titleMedium,
                ),
                // In future: list linked ideas here
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
