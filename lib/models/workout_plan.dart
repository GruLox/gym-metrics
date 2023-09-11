import 'package:gym_metrics/models/plan_exercise.dart';

class WorkoutPlan {
  final String name;
  List<PlanExercise> exerciseList;
  final String? workoutNote;

  WorkoutPlan({
    required this.name,
    required this.exerciseList,
    this.workoutNote,
  }); 
}