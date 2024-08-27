import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/screens/workout_plan_screen.dart';
import 'package:gym_metrics/mixins/exercise_management_mixin.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen>
    with ExerciseManagementMixin {
  late WorkoutPlan workoutPlan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workoutPlan = ModalRoute.of(context)?.settings.arguments as WorkoutPlan;
    if (exercises.isEmpty) {
      exercises = workoutPlan.exerciseList.reversed.toList();
    }
  }

  void onSave() {
    // Implement save functionality
  }

  @override
  Widget build(BuildContext context) {
    return WorkoutPlanScreen(
      title: 'Active Workout',
      isLoading: false,
      nameController: TextEditingController(text: workoutPlan.name),
      exercises: exercises,
      onExerciseAdded: () => onExerciseAdded(context),
      onExerciseRemoved: onExerciseRemoved,
      onSetAdded: onSetAdded,
      onSetRemoved: onSetRemoved,
      onSave: onSave,
    );
  }
}
