import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/widgets/exercise_card.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> exercises;
  final bool isOnExercisesScreen;

  const ExerciseList({
    super.key,
    required this.exercises,
    this.isOnExercisesScreen = false, 
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        return ExerciseCard(
          exercise: exercise,
          isOnExercisesScreen: isOnExercisesScreen, 
        );
      },
    );
  }
}