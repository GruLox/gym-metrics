import 'package:flutter/material.dart';
import 'package:gym_metrics/enums/muscle_group.dart';

class MuscleGroupDropdown extends StatelessWidget {
  final MuscleGroup muscleGroup;
  final ValueChanged<MuscleGroup?> onChanged;

  const MuscleGroupDropdown({
    super.key,
    required this.muscleGroup,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MuscleGroup>(
      value: muscleGroup,
      onChanged: onChanged,
      items: MuscleGroup.values.map((MuscleGroup group) {
        return DropdownMenuItem<MuscleGroup>(
          value: group,
          child: Text(group.muscleGroupToString()),
        );
      }).toList(),
    );
  }
}