import 'package:flutter/material.dart';
import 'package:gym_metrics/widgets/workout_plan_screen.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/states/workout_plan_state.dart';
import 'package:gym_metrics/mixins/exercise_set_management_mixin.dart';

class EditWorkoutPlanScreen extends StatefulWidget {
  const EditWorkoutPlanScreen({Key? key}) : super(key: key);

  @override
  State<EditWorkoutPlanScreen> createState() => _EditWorkoutPlanScreenState();
}

class _EditWorkoutPlanScreenState extends State<EditWorkoutPlanScreen> with ExerciseSetManagementMixin {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  late WorkoutPlan _workoutPlan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     _workoutPlan =
        ModalRoute.of(context)!.settings.arguments as WorkoutPlan;
    _nameController.text = _workoutPlan.name;
    if (exercises.isEmpty) {
      exercises = _workoutPlan.exerciseList.toList();
    }
  }

  Future<void> updateWorkoutPlan(WorkoutPlan workoutPlan) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final workoutState = Provider.of<WorkoutPlanState>(context, listen: false);
      await workoutState.updateWorkoutPlan(workoutPlan);
      Navigator.pop(context, workoutPlan);
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update workout plan: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
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
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout name cannot be empty')),
      );
      return;
    }

    final workoutPlan = ModalRoute.of(context)!.settings.arguments as WorkoutPlan;
    WorkoutPlan updatedWorkoutPlan = WorkoutPlan(
      id: workoutPlan.id,
      name: _nameController.text,
      exerciseList: exercises.toList(),
      workoutNote: workoutPlan.workoutNote,
    );
    updateWorkoutPlan(updatedWorkoutPlan);
  }

  @override
  Widget build(BuildContext context) {
    return WorkoutPlanScreen(
      title: 'Edit Workout Plan',
      isLoading: _isLoading,
      nameController: _nameController,
      exercises: exercises,
      onExerciseAdded: () => onExerciseAdded(context),
      onExerciseRemoved: onExerciseRemoved,
      onSetAdded: onSetAdded,
      onSetRemoved: onSetRemoved,
      onSave: onSave,
      isLocked: true,
    );
  }
}