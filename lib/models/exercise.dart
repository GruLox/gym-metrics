import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/states/exercise_state.dart';

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
    this.bestWeightSet,
    this.bestRepsSet,
    this.bestOneRepMaxSet,
  }) ;

  Future<void> updateBestSets(ExerciseSet newSet) async {
    bool updated = false;

    if (bestWeightSet == null || newSet.isWeightPR(bestWeightSet!.weight)) {
      bestWeightSet = newSet;
      updated = true;
    }
    if (bestRepsSet == null || newSet.isRepsPR(bestRepsSet!.reps)) {
      bestRepsSet = newSet;
      updated = true;
    }
    if (bestOneRepMaxSet == null || newSet.isOneRepMaxPR(bestOneRepMaxSet!.oneRepMax)) {
      bestOneRepMaxSet = newSet;
      updated = true;
    }

    if (updated) {
      ExerciseState().updatePRs(this);
    }

    print('Best weight set: $bestWeightSet');
    print('Best reps set: $bestRepsSet');
    print('Best one rep max set: $bestOneRepMaxSet');
  }
}
