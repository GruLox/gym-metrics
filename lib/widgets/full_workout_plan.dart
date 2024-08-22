
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/widgets/exercise_container.dart';

class FullWorkoutPlan extends StatefulWidget {

  List<WeightliftingSet> exercises;
  final bool isLocked;
  final Function(int index, ExerciseSet weightliftingSet) onSetAdded;
  final Function(int index, ExerciseSet weightliftingSet) onSetRemoved;
  final Function(int index) onExerciseRemoved;

  FullWorkoutPlan({
    super.key,
    required this.exercises,
    required this.onSetAdded,
    required this.onSetRemoved,
    required this.onExerciseRemoved,
    this.isLocked = false,
  });

  @override
  State<FullWorkoutPlan> createState() => _FullWorkoutPlanState();
}

class _FullWorkoutPlanState extends State<FullWorkoutPlan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 450.0,
          child: ListView.builder(
            itemCount: widget.exercises.length,
            itemBuilder: (context, index) {
              return ExerciseContainer(
                weightliftingSet: widget.exercises[index],
                index: index,
                onSetAddedCallback: widget.onSetAdded,
                onSetRemovedCallback: widget.onSetRemoved,
                onExerciseRemovedCallback: () => widget.onExerciseRemoved(index),
                isLocked: widget.isLocked,
              );
            },
          ),
        ),
    ElevatedButton(
      onPressed: () async {
        List<WeightliftingSet>? addedExercises =
            await Navigator.pushNamed(context, '/select-exercises')
                as List<WeightliftingSet>?;
        if (addedExercises != null) {
          setState(() {
            widget.exercises.addAll(addedExercises);
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Add Exercise',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ),
      ],
    );
  }
}
