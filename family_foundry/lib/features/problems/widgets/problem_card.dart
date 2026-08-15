import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/problem.dart';

class ProblemCard extends StatelessWidget {
  final Problem problem;
  const ProblemCard({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/problems/${problem.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                problem.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                problem.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                children: [
                  _InfoChip(icon: Icons.category_outlined, label: problem.category),
                  _InfoChip(icon: Icons.person_outline, label: 'by ${problem.postedBy}'),
                  _InfoChip(
                    icon: Icons.people_outline,
                    label: '${problem.interestedMembers.length} interested',
                  ),
                  _InfoChip(
                    icon: Icons.lightbulb_outline,
                    label: '${problem.potentialSolutions} solutions',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
