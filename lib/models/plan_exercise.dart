import 'package:gym_metrics/models/exercise.dart';

class PlanExercise {
  PlanExercise({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  final Exercise exercise;
  final int sets;
  final int reps;
  final int weight;
}