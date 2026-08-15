import '../models/problem.dart';
import '../local/mock_data.dart';
import 'problem_repository.dart';

class MockProblemRepository implements ProblemRepository {
  @override
  Future<List<Problem>> getAllProblems() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(mockProblems);
  }

  @override
  Future<Problem?> getProblemById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockProblems.cast<Problem?>().firstWhere(
      (p) => p!.id == id,
      orElse: () => null,
    );
  }
}
