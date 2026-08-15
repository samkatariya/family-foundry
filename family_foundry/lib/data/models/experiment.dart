class Experiment {
  final String id;
  final String hypothesis;
  final String owner;
  final DateTime deadline;
  final int target;
  final int progress;
  final String? result;

  const Experiment({
    required this.id,
    required this.hypothesis,
    required this.owner,
    required this.deadline,
    required this.target,
    this.progress = 0,
    this.result,
  });

  double get progressPercent => target > 0 ? progress / target : 0;
}
