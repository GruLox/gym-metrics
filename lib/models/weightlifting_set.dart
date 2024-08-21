import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';

class WeightliftingSet {
   WeightliftingSet({
    required this.exercise,
    List<ExerciseSet>? sets,
  }) : sets = sets ?? [const ExerciseSet()];

  final Exercise exercise;
  List<ExerciseSet> sets;

  void addSet(ExerciseSet set) {
    sets.add(set);
  }

  void removeSet(ExerciseSet set) {
    sets.remove(set);
  }

  void setSets(List<ExerciseSet> sets) {
    this.sets = sets;
  }

  @override
  String toString() {
    return 'WeightliftingSet(exercise: $exercise, sets: $sets)';
  }
}