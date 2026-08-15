import 'package:flutter/material.dart';
import '../../../data/models/skill.dart';

class SkillChip extends StatelessWidget {
  final Skill skill;
  final bool compact;

  const SkillChip({super.key, required this.skill, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill.name, style: TextStyle(fontSize: compact ? 11 : 13)),
      backgroundColor: _categoryColor(skill.category).withOpacity(0.15),
      side: BorderSide(color: _categoryColor(skill.category).withOpacity(0.4)),
      visualDensity: compact ? VisualDensity.compact : VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: compact ? const EdgeInsets.symmetric(horizontal: 4) : null,
    );
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Agriculture': return Colors.green;
      case 'Finance': return Colors.blueGrey;
      case 'Technology': return Colors.indigo;
      case 'Marketing': return Colors.orange;
      case 'Design': return Colors.purple;
      default: return Colors.teal;
    }
  }
}
