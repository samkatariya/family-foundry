import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/repositories/mock_member_repository.dart';
import '../../data/models/member.dart';
import 'widgets/skill_chip.dart';

final memberDetailProvider =
    FutureProvider.family<Member?, String>((ref, id) async {
  return MockMemberRepository().getMemberById(id);
});

class MemberDetailScreen extends ConsumerWidget {
  final String memberId;
  const MemberDetailScreen({super.key, required this.memberId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberAsync = ref.watch(memberDetailProvider(memberId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: memberAsync.when(
        data: (member) {
          if (member == null) {
            return const Center(child: Text('Member not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar and name
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: member.photoUrl != null
                        ? NetworkImage(member.photoUrl!)
                        : null,
                    child: member.photoUrl == null
                        ? Text(member.name[0],
                            style: const TextStyle(fontSize: 36))
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    member.name,
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                    child: Text(member.profession,
                        style: theme.textTheme.titleMedium)),
                const SizedBox(height: 24),
                // Skills
                if (member.skills.isNotEmpty) ...[
                  Text('Expertise', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children:
                        member.skills.map((s) => SkillChip(skill: s)).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                // Can help with – tappable to trigger search
                if (member.canHelpWith.isNotEmpty) ...[
                  Text('Can help with', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...member.canHelpWith.map((h) => InkWell(
                        onTap: () => context.push(
                          '/members?search=${Uri.encodeComponent(h)}',
                        ),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline,
                                  size: 18, color: Colors.green),
                              const SizedBox(width: 8),
                              Expanded(child: Text(h)),
                              Icon(Icons.search,
                                  size: 14,
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.6)),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 16),
                ],
                // Interested in
                if (member.interestedIn.isNotEmpty) ...[
                  Text('Interested in', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...member.interestedIn.map((i) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.star_outline,
                                size: 18, color: Colors.amber),
                            const SizedBox(width: 8),
                            Expanded(child: Text(i)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
                ],
                // Wants to learn
                if (member.wantsToLearn.isNotEmpty) ...[
                  Text('Wants to learn', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...member.wantsToLearn.map((l) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.school_outlined,
                                size: 18, color: Colors.blue),
                            const SizedBox(width: 8),
                            Expanded(child: Text(l)),
                          ],
                        ),
                      )),
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
