import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';

class WorkoutPlan {
  String id;
  String name;
  List<WeightliftingSet> exerciseList;
  final String? workoutNote;

  WorkoutPlan({
    required this.id,
    required this.name,
    required this.exerciseList,
    this.workoutNote,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exerciseList': exerciseList.map((set) => set.toMap()).toList(),
      'workoutNote': workoutNote,
    };
  }

  factory WorkoutPlan.fromMap(Map<String, dynamic> workoutPlanData) {
    final List<WeightliftingSet> exerciseList = (workoutPlanData['exerciseList'] as List<dynamic>).map((set) {
      final exerciseData = set['exercise'] as Map<String, dynamic>;
      final Exercise exercise = Exercise(
        id: exerciseData['id'] as String,
        name: exerciseData['name'] as String,
        muscleGroup: MuscleGroupExtension.fromString(exerciseData['muscleGroup']),
      );

      final List<ExerciseSet> sets = (set['sets'] as List<dynamic>).map((exerciseSet) {
        return ExerciseSet(
          reps: exerciseSet['reps'] as int,
          weight: exerciseSet['weight'] as int,
        );
      }).toList();

      return WeightliftingSet(exercise: exercise, sets: sets);
    }).toList();

    return WorkoutPlan(
      id: workoutPlanData['id'] as String,
      name: workoutPlanData['name'] as String? ?? '',
      exerciseList: exerciseList,
      workoutNote: workoutPlanData['workoutNote'] as String? ?? '',
    );
  }
}