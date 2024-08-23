class Exercise {
  String id;
  final String name;
  String? nameLowercase;
  final String muscleGroup;

  Exercise({
    required this.id,
    required this.name,
    this.nameLowercase,
    required this.muscleGroup,
  });
}
