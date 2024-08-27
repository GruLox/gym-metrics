import 'package:flutter/material.dart';

class MuscleGroupDropdown extends StatelessWidget {
  final String muscleGroup;
  final ValueChanged<String?> onChanged;

  const MuscleGroupDropdown({
    super.key,
    required this.muscleGroup,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Muscle Group'),
        const Spacer(),
        DropdownButton<String>(
          value: muscleGroup,
          items: const [
            DropdownMenuItem(
              value: 'None',
              child: Text('None'),
            ),
            DropdownMenuItem(
              value: 'Core',
              child: Text('Core'),
            ),
            DropdownMenuItem(
              value: 'Arms',
              child: Text('Arms'),
            ),
            DropdownMenuItem(
              value: 'Back',
              child: Text('Back'),
            ),
            DropdownMenuItem(
              value: 'Chest',
              child: Text('Chest'),
            ),
            DropdownMenuItem(
              value: 'Legs',
              child: Text('Legs'),
            ),
            DropdownMenuItem(
              value: 'Shoulders',
              child: Text('Shoulders'),
            ),
          ],
          onChanged: onChanged,
        ),
      ],
    );
  }
}