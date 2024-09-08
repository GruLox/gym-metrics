enum MuscleGroup {
  none,
  chest,
  back,
  legs,
  arms,
  shoulders,
  abs,
}

extension MuscleGroupExtension on MuscleGroup {
  String muscleGroupToString() {
    switch (this) {
      case MuscleGroup.none:
        return 'None';
      case MuscleGroup.chest:
        return 'Chest';
      case MuscleGroup.back:
        return 'Back';
      case MuscleGroup.legs:
        return 'Legs';
      case MuscleGroup.arms:
        return 'Arms';
      case MuscleGroup.shoulders:
        return 'Shoulders';
      case MuscleGroup.abs:
        return 'Abs';
      default:
        return '';
    }
  }

  static MuscleGroup fromString(String muscleGroup) {
    switch (muscleGroup) {
      case 'None':
        return MuscleGroup.none;
      case 'Chest':
        return MuscleGroup.chest;
      case 'Back':
        return MuscleGroup.back;
      case 'Legs':
        return MuscleGroup.legs;
      case 'Arms':
        return MuscleGroup.arms;
      case 'Shoulders':
        return MuscleGroup.shoulders;
      case 'Abs':
        return MuscleGroup.abs;
      default:
        throw ArgumentError('Invalid muscle group: $muscleGroup');
    }
  }
}