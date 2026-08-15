import '../models/idea.dart';
import '../local/mock_data.dart';
import 'idea_repository.dart';

class MockIdeaRepository implements IdeaRepository {
  @override
  Future<List<Idea>> getAllIdeas() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(mockIdeas);
  }

  @override
  Future<Idea?> getIdeaById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockIdeas.cast<Idea?>().firstWhere(
      (i) => i!.id == id,
      orElse: () => null,
    );
  }
}
