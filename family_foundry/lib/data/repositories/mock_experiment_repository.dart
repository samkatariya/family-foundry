import '../models/experiment.dart';
import '../local/mock_data.dart';
import 'experiment_repository.dart';

class MockExperimentRepository implements ExperimentRepository {
  @override
  Future<List<Experiment>> getAllExperiments() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(mockExperiments);
  }

  @override
  Future<Experiment?> getExperimentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockExperiments.cast<Experiment?>().firstWhere(
      (e) => e!.id == id,
      orElse: () => null,
    );
  }
}
