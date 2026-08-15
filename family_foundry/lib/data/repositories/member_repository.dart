import '../models/member.dart';

abstract class MemberRepository {
  Future<List<Member>> getAllMembers();
  Future<Member?> getMemberById(String id);
  Future<List<Member>> searchBySkill(String query);
}
