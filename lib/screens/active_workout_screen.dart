import 'package:flutter/material.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/states/ongoing_workout_state.dart';
import 'package:gym_metrics/states/workout_plan_state.dart';
import 'package:gym_metrics/widgets/workout_plan_screen.dart';
import 'package:gym_metrics/mixins/exercise_set_management_mixin.dart';
import 'package:provider/provider.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen>
    with ExerciseSetManagementMixin {
  late WorkoutPlan _workoutPlan;
  final FinishedWorkoutState _finishedWorkoutState = FinishedWorkoutState();
  final WorkoutPlanState _workoutPlanState = WorkoutPlanState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _workoutPlan = ModalRoute.of(context)?.settings.arguments as WorkoutPlan;
    if (exercises.isEmpty) {
      exercises = _workoutPlan.exerciseList.toList();
    }
  }

  @override
  void onExerciseRemoved(int index) {
    setState(() {
      exercises.removeAt(index);
    });
    _workoutPlan.exerciseList = exercises;
  }

  void onSave() {
    final finishedWorkout = FinishedWorkout.fromWorkoutPlan(
      workoutPlan: _workoutPlan,
      date: DateTime.now(),
      duration: 90,
    );
    _finishedWorkoutState.updateBestSetsOnSave(finishedWorkout);
    _finishedWorkoutState.addFinishedWorkout(finishedWorkout);
    // update WorkoutPlan to store performance data
    _workoutPlanState.updateWorkoutPlan(_workoutPlan);
    // remove ongoing workout
    Provider.of<OngoingWorkoutState>(context, listen: false).endWorkout();

    Navigator.pop(context);
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