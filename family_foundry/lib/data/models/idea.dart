enum IdeaStatus { discussion, validation, experiment, building, live, paused, dropped }

class Idea {
  final String id;
  final String title;
  final String? originProblemId;
  final IdeaStatus status;
  final List<String> peopleInvolved;
  final String? potentialCustomer;
  final String? nextAction;

  const Idea({
    required this.id,
    required this.title,
    this.originProblemId,
    this.status = IdeaStatus.discussion,
    this.peopleInvolved = const [],
    this.potentialCustomer,
    this.nextAction,
  });
}
