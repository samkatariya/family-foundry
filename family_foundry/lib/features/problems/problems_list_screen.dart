import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_problem_repository.dart';
import '../../data/models/problem.dart';
import 'widgets/problem_card.dart';

final problemsProvider = FutureProvider<List<Problem>>((ref) async {
  return MockProblemRepository().getAllProblems();
});

class ProblemsListScreen extends ConsumerWidget {
  const ProblemsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problemsAsync = ref.watch(problemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Problems'),
      ),
      body: problemsAsync.when(
        data: (problems) => problems.isEmpty
            ? const Center(child: Text('No problems yet. Add one!'))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: problems.length,
                itemBuilder: (context, index) =>
                    ProblemCard(problem: problems[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading problems: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Problem coming soon')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Problem'),
      ),
    );
  }
}
