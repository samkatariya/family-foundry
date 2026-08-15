import '../models/idea.dart';

abstract class IdeaRepository {
  Future<List<Idea>> getAllIdeas();
  Future<Idea?> getIdeaById(String id);
}
