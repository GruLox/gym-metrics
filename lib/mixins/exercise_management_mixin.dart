// lib/mixins/exercise_management_mixin.dart
import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/states/exercise_state.dart';
import 'package:provider/provider.dart';

mixin ExerciseManagementMixin<T extends StatefulWidget> on State<T> {
  late ExerciseState _exerciseState;
  List<Exercise> exercises = [];
  List<Exercise> filteredExercises = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _exerciseState = Provider.of<ExerciseState>(context, listen: false);
      refreshExercises();
    });
  }

  void refreshExercises() {
    _exerciseState.fetchExercises().then((_) {
      setState(() {
        exercises = _exerciseState.exercises;
        filteredExercises = exercises;
      });
    });
  }

  void filterExercises(String query) {
    setState(() {
      filteredExercises = exercises.where((exercise) {
        final exerciseName = exercise.name.toLowerCase();
        final muscleGroup = exercise.muscleGroup;
        final searchQuery = query.toLowerCase();
        return exerciseName.contains(searchQuery) ||
            muscleGroup.toString().contains(searchQuery);
      }).toList();
    });
  }
}