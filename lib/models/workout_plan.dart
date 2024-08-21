import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';

class WorkoutPlan {
  String name;
  List<WeightliftingSet> exerciseList;
  final String? workoutNote;

  WorkoutPlan({
    required this.name,
    required this.exerciseList,
    this.workoutNote,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> workoutPlanData = {
      'name': name,
      'exerciseList': exerciseList
          .map((set) => {
                'exercise': {
                  'exerciseName': set.exercise.name,
                  'muscleGroup': set.exercise.muscleGroup,
                },
                'sets': set.sets
                    .map((exerciseSet) => {
                          'reps': exerciseSet.reps,
                          'weight': exerciseSet.weight,
                        })
                    .toList(),
              })
          .toList(),
      'workoutNote': workoutNote,
    };
    return workoutPlanData;
  }

  // serialize method

factory WorkoutPlan.fromMap(Map<String, dynamic> workoutPlanData) {
  final List<WeightliftingSet> exerciseList = (workoutPlanData['exerciseList'] as List<dynamic>).map((set) {
    final exerciseData = set['exercise'] as Map<String, dynamic>;
    final Exercise exercise = Exercise(
      name: exerciseData['exerciseName'] as String,
      muscleGroup: exerciseData['muscleGroup'] as String,
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
    name: workoutPlanData['name'] as String? ?? '',
    exerciseList: exerciseList,
    workoutNote: workoutPlanData['workoutNote'] as String? ?? '',
  );
}
}

