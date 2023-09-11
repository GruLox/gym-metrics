import 'package:flutter/material.dart';
import 'package:gym_metrics/widgets/exercise_card.dart';

class SelectableExerciseCard extends ExerciseCard {
  const SelectableExerciseCard({
    super.key,
    required String name,
    required String muscleGroup,
  }) : super(
          name: name,
          muscleGroup: muscleGroup,
        );

  @override
  State<SelectableExerciseCard> createState() => _SelectableExerciseCardState();
}

class _SelectableExerciseCardState extends State<SelectableExerciseCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueGrey[800] : Colors.transparent,
        ),
        child: ExerciseCard(
          icon: isSelected ? Icons.check : kExerciseIcon,
          name: widget.name,
          muscleGroup: widget.muscleGroup,
        ),
      ),
    );
  }
}
