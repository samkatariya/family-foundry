import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/mock_member_repository.dart';
import '../../data/repositories/mock_problem_repository.dart';
import '../../data/repositories/mock_experiment_repository.dart';
import '../../data/models/problem.dart';
import '../../data/models/experiment.dart';
import '../../data/local/mock_data.dart';

final memberCountProvider = FutureProvider<int>((ref) async {
  final members = await MockMemberRepository().getAllMembers();
  return members.length;
});

final problemCountProvider = FutureProvider<int>((ref) async {
  final problems = await MockProblemRepository().getAllProblems();
  return problems.length;
});

final ideaCountProvider = FutureProvider<int>((ref) async {
  return mockIdeas.length;
});

final experimentCountProvider = FutureProvider<int>((ref) async {
  final experiments = await MockExperimentRepository().getAllExperiments();
  return experiments.length;
});

final activeExperimentsProvider = FutureProvider<List<Experiment>>((ref) async {
  final experiments = await MockExperimentRepository().getAllExperiments();
  return experiments.where((e) => e.result == null).toList();
});

final recentProblemsProvider = FutureProvider<List<Problem>>((ref) async {
  final problems = await MockProblemRepository().getAllProblems();
  return problems.length > 2
      ? problems.sublist(problems.length - 2)
      : problems;
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberCount = ref.watch(memberCountProvider);
    final problemCount = ref.watch(problemCountProvider);
    final ideaCount = ref.watch(ideaCountProvider);
    final experimentCount = ref.watch(experimentCountProvider);
    final activeExperiments = ref.watch(activeExperimentsProvider);
    final recentProblems = ref.watch(recentProblemsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Family Foundry Hub')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Good evening, Family Foundry',
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          // Stats row 1
          Row(
            children: [
              _StatCard(
                label: 'Members',
                value: memberCount.when(
                    data: (c) => '$c',
                    loading: () => '…',
                    error: (_, __) => '?'),
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'Problems',
                value: problemCount.when(
                    data: (c) => '$c',
                    loading: () => '…',
                    error: (_, __) => '?'),
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'Ideas',
                value: ideaCount.when(
                    data: (c) => '$c',
                    loading: () => '…',
                    error: (_, __) => '?'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Stats row 2
          Row(
            children: [
              _StatCard(
                label: 'Experiments',
                value: experimentCount.when(
                    data: (c) => '$c',
                    loading: () => '…',
                    error: (_, __) => '?'),
              ),
              const SizedBox(width: 12),
              Expanded(child: _MeetingPreview()),
            ],
          ),
          const SizedBox(height: 24),
          // Active experiments
          Text('Active Experiments', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          activeExperiments.when(
            data: (experiments) => experiments.isEmpty
                ? const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No active experiments'),
                    ),
                  )
                : Column(
                    children: experiments
                        .map((e) => Card(
                              child: ListTile(
                                leading: const Icon(Icons.science_outlined),
                                title: Text(
                                  e.hypothesis,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                    '${e.progress}/${e.target} · Owner: ${e.owner}'),
                                onTap: () =>
                                    context.push('/experiments/${e.id}'),
                              ),
                            ))
                        .toList(),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          // Recent problems
          Text('Recent Problems', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          recentProblems.when(
            data: (problems) => problems.isEmpty
                ? const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No problems posted yet'),
                    ),
                  )
                : Column(
                    children: problems
                        .map((p) => Card(
                              child: ListTile(
                                leading:
                                    const Icon(Icons.warning_amber_rounded),
                                title: Text(
                                  p.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                    'by ${p.postedBy} · ${p.potentialSolutions} solutions'),
                                onTap: () =>
                                    context.push('/problems/${p.id}'),
                              ),
                            ))
                        .toList(),
                  ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 24),
          // Quick actions
          Text('Quick Actions', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _QuickActionChip(
                icon: Icons.add_circle_outline,
                label: 'Add Problem',
                onTap: () => context.push('/problems'),
              ),
              _QuickActionChip(
                icon: Icons.lightbulb_outline,
                label: 'Add Idea',
                onTap: () => context.push('/ideas'),
              ),
              _QuickActionChip(
                icon: Icons.person_search,
                label: 'Find Someone',
                onTap: () => context.push('/members'),
              ),
              _QuickActionChip(
                icon: Icons.event,
                label: 'Meeting',
                onTap: () => context.push('/meetings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeetingPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final meeting = mockNextMeeting;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/meetings'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Icon(Icons.event_available, size: 28, color: Colors.green),
              const SizedBox(height: 4),
              Text(
                'Next Meeting',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                meeting['date'] as String,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}
