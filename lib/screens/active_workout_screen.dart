import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/workout_plan_screen.dart';
import 'package:gym_metrics/mixins/exercise_set_management_mixin.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen>
    with ExerciseSetManagementMixin {
  late WorkoutPlan _workoutPlan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _workoutPlan = ModalRoute.of(context)?.settings.arguments as WorkoutPlan;
    if (exercises.isEmpty) {
      exercises = _workoutPlan.exerciseList.reversed.toList();
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
      nameController: TextEditingController(text: _workoutPlan.name),
      exercises: exercises,
      onExerciseAdded: () => onExerciseAdded(context),
      onExerciseRemoved: onExerciseRemoved,
      onSetAdded: onSetAdded,
      onSetRemoved: onSetRemoved,
      onSave: onSave,
    );
  }
}
