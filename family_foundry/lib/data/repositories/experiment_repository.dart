import '../models/experiment.dart';

abstract class ExperimentRepository {
  Future<List<Experiment>> getAllExperiments();
  Future<Experiment?> getExperimentById(String id);
}
