import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_experiment_repository.dart';
import '../../data/models/experiment.dart';
import 'widgets/experiment_card.dart';

final experimentsProvider = FutureProvider<List<Experiment>>((ref) async {
  return MockExperimentRepository().getAllExperiments();
});

class ExperimentsListScreen extends ConsumerWidget {
  const ExperimentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experimentsAsync = ref.watch(experimentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Experiments')),
      body: experimentsAsync.when(
        data: (experiments) => experiments.isEmpty
            ? const Center(child: Text('No experiments yet.'))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: experiments.length,
                itemBuilder: (context, index) =>
                    ExperimentCard(experiment: experiments[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading experiments: $err')),
      ),
    );
  }
}
