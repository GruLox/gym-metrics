class ExerciseSet {
  int weight;
  int reps;
  bool isPR;
  int oneRepMax;
  bool isCompleted;

  ExerciseSet({this.weight = 0, this.reps = 0, this.isPR = false, this.isCompleted = false})
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

  ExerciseSet copy() {
    return ExerciseSet(
      weight: weight,
      reps: reps,
      isPR: isPR,
      isCompleted: isCompleted,
    );
  }

  ExerciseSet copyWith({
    int? weight,
    int? reps,
    bool? isPR,
    bool? isCompleted,
  }) {
    return ExerciseSet(
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      isPR: isPR ?? this.isPR,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
