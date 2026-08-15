import '../models/member.dart';
import '../local/mock_data.dart';
import 'member_repository.dart';

class MockMemberRepository implements MemberRepository {
  final List<Member> _members = mockMembers;

  @override
  Future<List<Member>> getAllMembers() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_members);
  }

  @override
  Future<Member?> getMemberById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _members.cast<Member?>().firstWhere(
      (m) => m!.id == id,
      orElse: () => null,
    );
  }

  @override
  Future<List<Member>> searchBySkill(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final lower = query.toLowerCase();
    return _members.where((m) {
      return m.skills.any((s) => s.name.toLowerCase().contains(lower)) ||
          m.canHelpWith.any((h) => h.toLowerCase().contains(lower)) ||
          m.profession.toLowerCase().contains(lower);
    }).toList();
  }
}
