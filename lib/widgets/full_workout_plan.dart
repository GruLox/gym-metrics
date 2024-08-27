import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/widgets/exercise_container.dart';

class FullWorkoutPlan extends StatefulWidget {
  final List<WeightliftingSet> exercises;
  final bool isLocked;
  final Function(int index, ExerciseSet weightliftingSet) onSetAdded;
  final Function(int index, ExerciseSet weightliftingSet) onSetRemoved;
  final Future<void> Function() onExerciseAdded;
  final Function(int index) onExerciseRemoved;

  const FullWorkoutPlan({
    super.key,
    required this.exercises,
    required this.onSetAdded,
    required this.onSetRemoved,
    required this.onExerciseAdded,
    required this.onExerciseRemoved,
    this.isLocked = false,
  });

  @override
  State<FullWorkoutPlan> createState() => _FullWorkoutPlanState();
}

class _FullWorkoutPlanState extends State<FullWorkoutPlan> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.exercises.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.exercises.length) {
                return TextButton(
                  onPressed: () async {
                    await widget.onExerciseAdded();
                    setState(() {});
                  },
                  child: const Text(
                    'ADD EXERCISE',
                    style: TextStyle(fontSize: 16.0, color: kPrimaryColor),
                  ),
                );
              } else {
                return ExerciseContainer(
                  key: ValueKey(widget.exercises[index].exercise.id),
                  weightliftingSet: widget.exercises[index],
                  index: index,
                  onSetAddedCallback: widget.onSetAdded,
                  onSetRemovedCallback: widget.onSetRemoved,
                  onExerciseRemovedCallback: () {
                    setState(() {
                      widget.onExerciseRemoved(index);
                    });
                  },
                  isLocked: widget.isLocked,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
