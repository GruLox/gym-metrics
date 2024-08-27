import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/mixins/exercise_management_mixin.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/full_workout_plan.dart';
import 'package:gym_metrics/states/workout_state.dart';
import 'package:provider/provider.dart';

class AddWorkoutPlanScreen extends StatefulWidget {
  const AddWorkoutPlanScreen({
    super.key,
  });

  @override
  State<AddWorkoutPlanScreen> createState() => _AddWorkoutPlanScreenState();
}

class _AddWorkoutPlanScreenState extends State<AddWorkoutPlanScreen>
    with ExerciseManagementMixin {
  final TextEditingController _nameController = TextEditingController();

  void uploadWorkoutPlan(WorkoutPlan addedWorkoutPlan) async {
    final workoutState = Provider.of<WorkoutState>(context, listen: false);
    await workoutState.addWorkoutPlan(addedWorkoutPlan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Create a New Plan', style: TextStyle(fontSize: 25.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              WorkoutPlan addedWorkoutPlan = WorkoutPlan(
                id: '',
                name: _nameController.text,
                exerciseList: exercises.reversed.toList(),
              );
              uploadWorkoutPlan(addedWorkoutPlan);
              Navigator.pop(context, addedWorkoutPlan);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 30.0,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black),
                decoration: kWhiteInputDecoration.copyWith(
                  hintText: 'Workout Name',
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            FullWorkoutPlan(
              exercises: exercises,
              onSetAdded: onSetAdded,
              onSetRemoved: onSetRemoved,
              onExerciseAdded: () => onExerciseAdded(context),
              onExerciseRemoved: onExerciseRemoved,
              isLocked: true,
            ),
          ],
        ),
      ),
    );
  }
}
