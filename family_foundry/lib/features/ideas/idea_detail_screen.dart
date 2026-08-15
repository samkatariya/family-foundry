import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_idea_repository.dart';
import '../../data/models/idea.dart';

final ideaDetailProvider =
    FutureProvider.family<Idea?, String>((ref, id) async {
  return MockIdeaRepository().getIdeaById(id);
});

class IdeaDetailScreen extends ConsumerWidget {
  final String ideaId;
  const IdeaDetailScreen({super.key, required this.ideaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideaAsync = ref.watch(ideaDetailProvider(ideaId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Idea')),
      body: ideaAsync.when(
        data: (idea) {
          if (idea == null) {
            return const Center(child: Text('Idea not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  idea.title,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _StatusBadge(status: idea.status),
                const SizedBox(height: 16),
                if (idea.originProblemId != null)
                  Text(
                    'Originated from Problem #${idea.originProblemId}',
                    style: theme.textTheme.bodySmall,
                  ),
                const Divider(height: 24),
                if (idea.potentialCustomer != null) ...[
                  Text('Target Customer', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(idea.potentialCustomer!),
                  const SizedBox(height: 16),
                ],
                if (idea.peopleInvolved.isNotEmpty) ...[
                  Text('People involved', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: idea.peopleInvolved
                        .map((name) => Chip(
                              avatar: CircleAvatar(child: Text(name[0])),
                              label: Text(name),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                if (idea.nextAction != null) ...[
                  Text('Next Action', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    '▶ ${idea.nextAction}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
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

class _StatusBadge extends StatelessWidget {
  final IdeaStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      IdeaStatus.discussion => Colors.blue,
      IdeaStatus.validation => Colors.orange,
      IdeaStatus.experiment => Colors.purple,
      IdeaStatus.building => Colors.teal,
      IdeaStatus.live => Colors.green,
      IdeaStatus.paused => Colors.grey,
      IdeaStatus.dropped => Colors.red,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
