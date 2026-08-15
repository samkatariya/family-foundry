class ActionItem {
  final String id;
  final String description;
  final String assignedTo;
  final bool isDone;
  final String? relatedExperimentId;

  const ActionItem({
    required this.id,
    required this.description,
    required this.assignedTo,
    this.isDone = false,
    this.relatedExperimentId,
  });
}
