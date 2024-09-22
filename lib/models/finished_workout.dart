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
    return  {
      'id': id,
      'name': name,
      'exerciseList': exerciseList.map((set) => set.toMap()).toList(),
      'workoutNote': workoutNote,
      'date': date ,
      'duration': duration,
    };
  }

  factory FinishedWorkout.fromMap(Map<String, dynamic> workoutPlanData) {
    return FinishedWorkout(
      id: workoutPlanData['id'],
      name: workoutPlanData['name'],
      exerciseList: List<WeightliftingSet>.from(
          workoutPlanData['exerciseList']?.map((x) => WeightliftingSet.fromMap(x))),
      workoutNote: workoutPlanData['workoutNote'],
      date: workoutPlanData['date'].toDate(),
      duration: workoutPlanData['duration'],
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
