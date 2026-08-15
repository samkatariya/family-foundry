class Problem {
  final String id;
  final String title;
  final String description;
  final String postedBy;
  final String category;
  final List<String> interestedMembers;
  final int potentialSolutions;

  const Problem({
    required this.id,
    required this.title,
    required this.description,
    required this.postedBy,
    required this.category,
    this.interestedMembers = const [],
    this.potentialSolutions = 0,
  });
}
