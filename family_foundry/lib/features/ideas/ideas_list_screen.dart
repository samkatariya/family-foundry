import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_idea_repository.dart';
import '../../data/models/idea.dart';
import 'widgets/idea_card.dart';

final ideasProvider = FutureProvider<List<Idea>>((ref) async {
  return MockIdeaRepository().getAllIdeas();
});

class IdeasListScreen extends ConsumerWidget {
  const IdeasListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideasAsync = ref.watch(ideasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ideas'),
      ),
      body: ideasAsync.when(
        data: (ideas) => ideas.isEmpty
            ? const Center(child: Text('No ideas yet. Add one!'))
            : ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                itemCount: ideas.length,
                itemBuilder: (context, index) => IdeaCard(idea: ideas[index]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('Error loading ideas: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Idea coming soon')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Idea'),
      ),
    );
  }
}
