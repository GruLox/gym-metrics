import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/widgets/full_workout_plan.dart';

class WorkoutPlanScreen extends StatefulWidget {
  final String title;
  final bool isLoading;
  final bool isLocked;
  final TextEditingController nameController;
  final List<WeightliftingSet> exercises;
  final Future<void> Function() onExerciseAdded;
  final void Function(int) onExerciseRemoved;
  final void Function(int, ExerciseSet) onSetAdded;
  final void Function(int, ExerciseSet) onSetRemoved;
  final void Function() onSave;

  const WorkoutPlanScreen({
    Key? key,
    required this.title,
    required this.isLoading,
    required this.nameController,
    required this.exercises,
    required this.onExerciseAdded,
    required this.onExerciseRemoved,
    required this.onSetAdded,
    required this.onSetRemoved,
    required this.onSave,
    this.isLocked = false,
  }) : super(key: key);

  @override
  _WorkoutPlanScreenState createState() => _WorkoutPlanScreenState();
}

class _WorkoutPlanScreenState extends State<WorkoutPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 25.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: widget.isLoading ? null : widget.onSave,
          ),
        ],
      ),
      body: widget.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: widget.nameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: kWhiteInputDecoration.copyWith(
                        hintText: 'Workout Name',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  FullWorkoutPlan(
                    exercises: widget.exercises,
                    onSetAdded: widget.onSetAdded,
                    onSetRemoved: widget.onSetRemoved,
                    onExerciseAdded: widget.onExerciseAdded,
                    onExerciseRemoved: widget.onExerciseRemoved,
                    isLocked: widget.isLocked,
                  ),
                ],
              ),
            ),
    );
  }
}