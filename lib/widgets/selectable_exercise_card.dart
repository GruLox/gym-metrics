import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/widgets/exercise_card.dart';

class SelectableExerciseCard extends ExerciseCard {
  const SelectableExerciseCard({
    super.key,
    required Exercise exercise,
    required this.selectionCallback,
  }) : super(exercise: exercise);

  final void Function() selectionCallback;

  @override
  State<SelectableExerciseCard> createState() => _SelectableExerciseCardState();
}

class _SelectableExerciseCardState extends State<SelectableExerciseCard> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.selectionCallback();
        });
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : Colors.transparent,
        ),
        child: ExerciseCard(
          icon: isSelected ? Icons.check : kExerciseIcon,
          exercise: widget.exercise,
        ),
      ),
    );
  }
}
