import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/models/workout_plan.dart';

class FinishedWorkout extends WorkoutPlan {
  final DateTime date;
  final int duration;
  final int totalWeightLifted;
  final int prs = 0;

  FinishedWorkout({
    required String id,
    required String name,
    required List<WeightliftingSet> exerciseList,
    String? workoutNote,
    required this.date,
    required this.duration,
  })  : totalWeightLifted = _calculateTotalWeightLifted(exerciseList),
        super(
          id: id,
          name: name,
          exerciseList: exerciseList,
          workoutNote: workoutNote,
        );

  FinishedWorkout.fromWorkoutPlan({
    required WorkoutPlan workoutPlan,
    required this.date,
    required this.duration,
  })  : totalWeightLifted = workoutPlan.exerciseList.fold(0, (sum, set) {
          return sum +
              set.sets.fold(0, (setSum, exerciseSet) {
                return setSum + (exerciseSet.reps * exerciseSet.weight);
              });
        }),
        super(
          id: workoutPlan.id,
          name: workoutPlan.name,
          exerciseList: workoutPlan.exerciseList,
          workoutNote: workoutPlan.workoutNote,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exerciseList': exerciseList
          .map((set) => {
                'exercise': {
                  'exerciseName': set.exercise.name,
                  'muscleGroup': set.exercise.muscleGroup.muscleGroupToString(),
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
      'date': date.toIso8601String(),
      'duration': duration,
      'totalWeightLifted': totalWeightLifted,
    };
  }

  factory FinishedWorkout.fromMap(Map<String, dynamic> workoutPlanData) {
    final List<WeightliftingSet> exerciseList =
        (workoutPlanData['exerciseList'] as List<dynamic>).map((set) {
      final Exercise exercise = Exercise(
        id: '',
        name: set['exercise']['exerciseName'] as String,
        muscleGroup: MuscleGroupExtension.fromString(
            set['exercise']['muscleGroup'] as String),
      );

      final List<ExerciseSet> sets =
          (set['sets'] as List<dynamic>).map((exerciseSet) {
        return ExerciseSet(
          reps: exerciseSet['reps'] as int,
          weight: exerciseSet['weight'] as int,
        );
      }).toList();

      return WeightliftingSet(exercise: exercise, sets: sets);
    }).toList();

    return FinishedWorkout(
      id: workoutPlanData['id'] as String,
      name: workoutPlanData['name'] as String,
      exerciseList: exerciseList,
      workoutNote: workoutPlanData['workoutNote'] as String?,
      date: DateTime.parse(workoutPlanData['date'] as String),
      duration: workoutPlanData['duration'] as int,
    );
  }

  static int _calculateTotalWeightLifted(List<WeightliftingSet> exerciseList) {
    return exerciseList.fold(0, (sum, set) {
      return sum +
          set.sets.fold(0, (setSum, exerciseSet) {
            return setSum + (exerciseSet.reps * exerciseSet.weight);
          });
    });
  }
}
