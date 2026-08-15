import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/idea.dart';

class IdeaCard extends StatelessWidget {
  final Idea idea;
  const IdeaCard({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/ideas/${idea.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      idea.title,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  _StatusBadge(status: idea.status),
                ],
              ),
              const SizedBox(height: 8),
              if (idea.potentialCustomer != null)
                Text(
                  'Customer: ${idea.potentialCustomer}',
                  style: theme.textTheme.bodySmall,
                ),
              const SizedBox(height: 4),
              if (idea.peopleInvolved.isNotEmpty)
                Text(
                  '👥 ${idea.peopleInvolved.join(', ')}',
                  style: theme.textTheme.bodySmall,
                ),
              const SizedBox(height: 4),
              if (idea.nextAction != null)
                Text(
                  '▶ ${idea.nextAction}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
