import 'package:gym_metrics/enums/muscle_group.dart';

class Exercise {
  String id;
  final String name;
  String? nameLowercase;
  final MuscleGroup muscleGroup;

  Exercise({
    required this.id,
    required this.name,
    this.nameLowercase,
    required this.muscleGroup,
  });
}
