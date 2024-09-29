import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/widgets/full_workout_plan.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/mixins/exercise_set_management_mixin.dart';

class EditFinishedWorkoutScreen extends StatefulWidget {
  const EditFinishedWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<EditFinishedWorkoutScreen> createState() => _EditFinishedWorkoutScreenState();
}

class _EditFinishedWorkoutScreenState extends State<EditFinishedWorkoutScreen> with ExerciseSetManagementMixin {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  late FinishedWorkout _finishedWorkout;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _finishedWorkout = ModalRoute.of(context)!.settings.arguments as FinishedWorkout;
    _nameController.text = _finishedWorkout.name;
    if (exercises.isEmpty) {
      exercises = _finishedWorkout.exerciseList.reversed.toList();
    }
  }

  Future<void> updateFinishedWorkout(FinishedWorkout finishedWorkout) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final finishedWorkoutState = Provider.of<FinishedWorkoutState>(context, listen: false);
      await finishedWorkoutState.updateFinishedWorkout(finishedWorkout);
      Navigator.pop(context, finishedWorkout);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update finished workout: $e')),
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
    _finishedWorkout.exerciseList = exercises;
  }

  void onSave() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout name cannot be empty')),
      );
      return;
    }

    FinishedWorkout updatedFinishedWorkout = FinishedWorkout(
      id: _finishedWorkout.id,
      name: _nameController.text,
      exerciseList: exercises.reversed.toList(),
      date: _finishedWorkout.date,
      duration: _finishedWorkout.duration,
    );
    updateFinishedWorkout(updatedFinishedWorkout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Finished Workout', style: TextStyle(fontSize: 25.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _isLoading ? null : onSave,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
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
                  ),
                ],
              ),
            ),
    );
  }
}