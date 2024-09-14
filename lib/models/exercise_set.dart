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
    return '$weight x $reps';
  }
}
