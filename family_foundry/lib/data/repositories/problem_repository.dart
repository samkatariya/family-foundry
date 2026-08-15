import '../models/problem.dart';

abstract class ProblemRepository {
  Future<List<Problem>> getAllProblems();
  Future<Problem?> getProblemById(String id);
}
