import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/member.dart';
import 'skill_chip.dart';

class MemberCard extends StatelessWidget {
  final Member member;
  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/members/${member.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: member.photoUrl != null ? NetworkImage(member.photoUrl!) : null,
                child: member.photoUrl == null ? Text(member.name[0], style: const TextStyle(fontSize: 28)) : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text(member.profession, style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    const SizedBox(height: 6),
                    if (member.skills.isNotEmpty)
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: member.skills.take(3).map((s) => SkillChip(skill: s, compact: true)).toList(),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
