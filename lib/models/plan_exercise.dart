import 'package:gym_metrics/models/exercise.dart';

class PlanExercise {
  PlanExercise({
    required this.exercise,
    this.sets = 1,
    this.reps = 0,
    this.weight = 0, 
  });

  final Exercise exercise;
  final int sets;
  final int reps;
  final int weight;
}