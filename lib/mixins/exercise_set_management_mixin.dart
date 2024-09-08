import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';

mixin ExerciseSetManagementMixin<T extends StatefulWidget> on State<T> {
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
    setState(() {
      exercises.removeAt(index);
    });
  }

  void onSetAdded(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].addSet(weightliftingSet);
    });
  }

  void onSetRemoved(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].removeSet(weightliftingSet);
      if (exercises[index].sets.isEmpty) {
        onExerciseRemoved(index);
      }
    });
  }
}
