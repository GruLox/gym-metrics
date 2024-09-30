import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/widgets/completion_icon.dart';
import 'package:gym_metrics/widgets/dismiss_background.dart';
import 'package:gym_metrics/widgets/workout_input_widget.dart';
import 'package:gym_metrics/widgets/set_number_display.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/states/ongoing_workout_state.dart';

class ExerciseSetRow extends StatefulWidget {
  const ExerciseSetRow({
    super.key,
    required this.setNumber,
    required this.exerciseSet,
    required this.onSetDismissedCallback,
    required this.exerciseIndex,
    required this.exerciseId,
    required this.onExerciseSetChanged,
    this.isLocked = false,
    this.isEditing = false, 
  });

  final bool isLocked;
  final bool isEditing; 
  final int setNumber;
  final int exerciseIndex;
  final String exerciseId;
  final ExerciseSet exerciseSet;
  final Function(int) onSetDismissedCallback;
  final Function(int, ExerciseSet) onExerciseSetChanged;

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  late ExerciseSet _editableExerciseSet;
  late ExerciseSet _previousExerciseSet;
  late TextEditingController _repsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _editableExerciseSet = widget.exerciseSet.copy();
    _editableExerciseSet.isCompleted =
        _editableExerciseSet.isCompleted || widget.isEditing;
    _previousExerciseSet =
        Provider.of<FinishedWorkoutState>(context, listen: false)
            .getPreviousExerciseSet(widget.exerciseId, widget.setNumber - 1);
    _repsController = TextEditingController(
        text: "${widget.isEditing ? _editableExerciseSet.reps : ""}");
    _weightController = TextEditingController(
        text: "${widget.isEditing ? _editableExerciseSet.weight : ""}");
  }

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _onRepsSubmitted(String value) {
    final newReps = int.tryParse(value) ?? 0;
    if (newReps != _editableExerciseSet.reps) {
      setState(() {
        _editableExerciseSet.reps = newReps;
        _notifyState();
      });
    }
  }

  void _onWeightSubmitted(String value) {
    final newWeight = int.tryParse(value) ?? 0;
    if (newWeight != _editableExerciseSet.weight) {
      setState(() {
        _editableExerciseSet.weight = newWeight;
        _notifyState();
      });
    }
  }

  void _toggleCompletion() {
    setState(() {
      _editableExerciseSet.isCompleted = !_editableExerciseSet.isCompleted;
      _notifyState();
    });
  }

  void _notifyState() {
    widget.onExerciseSetChanged(widget.setNumber - 1, _editableExerciseSet);
    if (!widget.isEditing) {
      // Only notify state if not in editing mode
      final ongoingWorkoutState =
          Provider.of<OngoingWorkoutState>(context, listen: false);
      ongoingWorkoutState.updateExerciseSet(widget.exerciseIndex,
          widget.setNumber - 1, _editableExerciseSet.copy());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _editableExerciseSet.isCompleted
          ? const Color(0xFF11664a)
          : Colors.transparent,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          widget.onSetDismissedCallback(widget.setNumber);
        },
        background: const DismissBackground(),
        child: Row(
          children: [
            Expanded(
                flex: 3, child: SetNumberDisplay(setNumber: widget.setNumber)),
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  _previousExerciseSet
                      .toString(), // Display previous performance
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: WorkoutInputWidget(
                controller: _weightController,
                startingData: _editableExerciseSet.weight,
                onSubmitted: _onWeightSubmitted,
              ),
            ),
            Expanded(
              flex: 5,
              child: WorkoutInputWidget(
                controller: _repsController,
                startingData: _editableExerciseSet.reps,
                onSubmitted: _onRepsSubmitted,
              ),
            ),
            Expanded(
              flex: 3,
              child: CompletionIcon(
                isLocked: widget.isLocked,
                isCompleted: _editableExerciseSet.isCompleted,
                onPressed: _toggleCompletion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
