class ExerciseSet {
  int weight;
  int reps;
  bool isPR;
  int oneRepMax;

  ExerciseSet({this.weight = 0, this.reps = 0, this.isPR = false})
      : oneRepMax = calculate1RM(weight, reps);

  static int calculate1RM(int weight, int reps) {
    // Epley Formula
    return (weight * (1 + 0.0333 * reps)).ceil();
  }

  bool isWeightPR(int bestWeight) => weight > bestWeight;
  bool isRepsPR(int bestReps) => reps > bestReps;
  bool isOneRepMaxPR(int bestOneRepMax) => oneRepMax > bestOneRepMax;

  @override
  String toString() {
    if (reps == 0 && weight == 0) {
      return '-';
    }
    return '$weight kg x $reps';
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'reps': reps,
      'pr': isPR,
    };
  }

  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      weight: map['weight'] as int,
      reps: map['reps'] as int,
      isPR: map['pr'] as bool,
    );
  }
}
