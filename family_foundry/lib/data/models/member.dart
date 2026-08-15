import 'skill.dart';

class Member {
  final String id;
  final String name;
  final String? photoUrl;
  final String profession;
  final List<Skill> skills;
  final List<String> canHelpWith;
  final List<String> interestedIn;
  final List<String> wantsToLearn;

  const Member({
    required this.id,
    required this.name,
    this.photoUrl,
    required this.profession,
    this.skills = const [],
    this.canHelpWith = const [],
    this.interestedIn = const [],
    this.wantsToLearn = const [],
  });
}
