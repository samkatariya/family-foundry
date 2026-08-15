import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_experiment_repository.dart';
import '../../data/repositories/mock_action_item_repository.dart';
import '../../data/models/experiment.dart';
import '../../data/models/action_item.dart';

final experimentDetailProvider =
    FutureProvider.family<Experiment?, String>((ref, id) async {
  return MockExperimentRepository().getExperimentById(id);
});

final experimentActionsProvider =
    FutureProvider.family<List<ActionItem>, String>((ref, id) async {
  return MockActionItemRepository().getActionsForExperiment(id);
});

class ExperimentDetailScreen extends ConsumerWidget {
  final String experimentId;
  const ExperimentDetailScreen({super.key, required this.experimentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experimentAsync = ref.watch(experimentDetailProvider(experimentId));
    final actionsAsync = ref.watch(experimentActionsProvider(experimentId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Experiment')),
      body: experimentAsync.when(
        data: (experiment) {
          if (experiment == null) {
            return const Center(child: Text('Not found'));
          }
          final progress = experiment.progressPercent;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hypothesis', style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(experiment.hypothesis, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('Owner: ${experiment.owner}'),
                    const Spacer(),
                    Text(
                      'Deadline: ${experiment.deadline.day}/${experiment.deadline.month}/${experiment.deadline.year}',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text('Progress: ${experiment.progress}/${experiment.target}'),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress),
                if (experiment.result != null) ...[
                  const SizedBox(height: 12),
                  Text('Result: ${experiment.result}'),
                ],
                const SizedBox(height: 24),
                Text('Action Items', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                actionsAsync.when(
                  data: (actions) => actions.isEmpty
                      ? const Text('No actions yet.')
                      : Column(
                          children: actions
                              .map((a) => CheckboxListTile(
                                    title: Text(a.description),
                                    subtitle:
                                        Text('Assigned to: ${a.assignedTo}'),
                                    value: a.isDone,
                                    onChanged: (_) {}, // read-only for now
                                  ))
                              .toList(),
                        ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text('Error: $e'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
