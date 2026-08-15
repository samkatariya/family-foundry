import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/experiment.dart';

class ExperimentCard extends StatelessWidget {
  final Experiment experiment;
  const ExperimentCard({super.key, required this.experiment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = experiment.progressPercent;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/experiments/${experiment.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experiment.hypothesis,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 4),
                  Text(experiment.owner),
                  const Spacer(),
                  Text(
                    'Deadline: ${experiment.deadline.day}/${experiment.deadline.month}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: progress),
              const SizedBox(height: 4),
              Text(
                '${experiment.progress}/${experiment.target} completed',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
