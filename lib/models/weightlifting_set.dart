import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';

class WeightliftingSet {
  final Exercise exercise;
  List<ExerciseSet> sets;

  ExerciseSet get bestSet {
    return sets.reduce((current, next) {
      return current.oneRepMax > next.oneRepMax ? current : next;
    });
  } 
  
  WeightliftingSet({
    required this.exercise,
    List<ExerciseSet>? sets,
  }) : sets = sets ?? [ExerciseSet()];


  void addSet(ExerciseSet set) {
    sets.add(set);
  }

  void removeSet(ExerciseSet set) {
    sets.remove(set);
    if (sets.isEmpty) {
      exercise.bestWeightSet = null;
      exercise.bestRepsSet = null;
      exercise.bestOneRepMaxSet = null;
    }
  }

  void setSets(List<ExerciseSet> sets) {
    this.sets = sets;
  }

  @override
  String toString() {
    return 'WeightliftingSet(exercise: $exercise, sets: $sets)';
  }

  // Add fromMap and toMap methods for serialization
  factory WeightliftingSet.fromMap(Map<String, dynamic> map) {
    return WeightliftingSet(
      exercise: Exercise.fromMap(map['exercise']),
      sets: List<ExerciseSet>.from(map['sets']?.map((x) => ExerciseSet.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise.toMap(),
      'sets': sets.map((x) => x.toMap()).toList(),
    };
  }
}
