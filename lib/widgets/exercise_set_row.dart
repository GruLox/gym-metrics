import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/widgets/completion_icon.dart';
import 'package:gym_metrics/widgets/dismiss_background.dart';
import 'package:gym_metrics/widgets/workout_input_widget.dart';
import 'package:gym_metrics/widgets/set_number_display.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/states/ongoing_workout_state.dart';
import 'dart:async';

class ExerciseSetRow extends StatefulWidget {
  const ExerciseSetRow({
    super.key,
    required this.setNumber,
    required this.exerciseSet,
    this.isLocked = false,
    required this.onSetDismissedCallback,
    required this.exerciseIndex,
  });

  final bool isLocked;
  final int setNumber;
  final ExerciseSet exerciseSet;
  final Function(int) onSetDismissedCallback;
  final int exerciseIndex;

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  late ExerciseSet _currentExerciseSet;
  late ExerciseSet _previousExerciseSet;
  late TextEditingController _repsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _currentExerciseSet = widget.exerciseSet.copy();
    _previousExerciseSet = widget.exerciseSet.copy();
    _repsController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _onRepsSubmitted(String value) {
    final newReps = int.tryParse(value) ?? 0;
    if (newReps != _currentExerciseSet.reps) {
      setState(() {
        _currentExerciseSet.reps = newReps;
        _notifyState();
      });
    }
  }

  void _onWeightSubmitted(String value) {
    final newWeight = int.tryParse(value) ?? 0;
    if (newWeight != _currentExerciseSet.weight) {
      setState(() {
        _currentExerciseSet.weight = newWeight;
        _notifyState();
      });
    }
  }

  void _toggleCompletion() {
    setState(() {
      _currentExerciseSet.isCompleted = !_currentExerciseSet.isCompleted;
      _notifyState();
    });
  }

  void _notifyState() {
    final ongoingWorkoutState = Provider.of<OngoingWorkoutState>(context, listen: false);
    ongoingWorkoutState.updateExerciseSet(widget.exerciseIndex, widget.setNumber - 1, _currentExerciseSet.copy());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _currentExerciseSet.isCompleted ? const Color(0xFF11664a) : Colors.transparent,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          widget.onSetDismissedCallback(widget.setNumber);
        },
        background: const DismissBackground(),
        child: Row(
          children: [
            Expanded(flex: 3, child: SetNumberDisplay(setNumber: widget.setNumber)),
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  _previousExerciseSet.toString(), // Display previous performance
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: WorkoutInputWidget(
                controller: _weightController,
                startingData: _currentExerciseSet.weight,
                onSubmitted: _onWeightSubmitted,
              ),
            ),
            Expanded(
              flex: 5,
              child: WorkoutInputWidget(
                controller: _repsController,
                startingData: _currentExerciseSet.reps,
                onSubmitted: _onRepsSubmitted,
              ),
            ),
            Expanded(
              flex: 3,
              child: CompletionIcon(
                isLocked: widget.isLocked,
                isCompleted: _currentExerciseSet.isCompleted,
                onPressed: _toggleCompletion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}