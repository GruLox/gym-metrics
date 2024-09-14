import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/models/exercise_set.dart';

class Exercise {
  String id;
  final String name;
  String? nameLowercase;
  final MuscleGroup muscleGroup;
  ExerciseSet? bestWeightSet;
  ExerciseSet? bestRepsSet;
  ExerciseSet? bestOneRepMaxSet;

  Exercise({
    required this.id,
    required this.name,
    this.nameLowercase,
    required this.muscleGroup,
  });

  void updateBestSets(ExerciseSet newSet) {
    if (bestWeightSet == null || newSet.isWeightPR(bestWeightSet!.weight)) {
      bestWeightSet = newSet;
    }
    if (bestRepsSet == null || newSet.isRepsPR(bestRepsSet!.reps)) {
      bestRepsSet = newSet;
    }
    if (bestOneRepMaxSet == null || newSet.isOneRepMaxPR(bestOneRepMaxSet!.oneRepMax)) {
      bestOneRepMaxSet = newSet;
    }
  }
}
