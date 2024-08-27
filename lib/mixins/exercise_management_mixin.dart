import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';

mixin ExerciseManagementMixin<T extends StatefulWidget> on State<T> {
  List<WeightliftingSet> exercises = [];

  Future<void> onExerciseAdded(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/select-exercises');
    if (result != null && result is List<WeightliftingSet>) {
      setState(() {
        exercises.addAll(result);
      });
    }
  }

  void onExerciseRemoved(int index) {
    print('Removing exercise at index: $index');
    setState(() {
      exercises.removeAt(index);
    });
    print('Remaining exercises: $exercises');
  }

  void onSetAdded(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].addSet(weightliftingSet);
    });
  }

  void onSetRemoved(int index, ExerciseSet weightliftingSet) {
    print('Removing set: $weightliftingSet from exercise at index: $index');
    setState(() {
      exercises[index].removeSet(weightliftingSet);
      if (exercises[index].sets.isEmpty) {
        onExerciseRemoved(index);
      }
    });
  }
}