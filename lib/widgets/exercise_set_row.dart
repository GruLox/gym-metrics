import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/widgets/completion_icon.dart';
import 'package:gym_metrics/widgets/dismiss_background.dart';
import 'package:gym_metrics/widgets/reps_input.dart';
import 'package:gym_metrics/widgets/set_number_display.dart';
import 'package:gym_metrics/widgets/weight_input.dart';

class ExerciseSetRow extends StatefulWidget {
  const ExerciseSetRow({
    super.key,
    required this.setNumber,
    required this.exerciseSet,
    this.isLocked = false,
    required this.onSetDismissedCallback,
  });

  final bool isLocked;
  final int setNumber;
  final ExerciseSet exerciseSet;
  final Function(int) onSetDismissedCallback;

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  bool _isCompleted = false;
  late TextEditingController _repsController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController();
    _weightController = TextEditingController();

    _repsController.addListener(_updateReps);
    _weightController.addListener(_updateWeight);
  }

  @override
  void dispose() {
    _repsController.removeListener(_updateReps);
    _weightController.removeListener(_updateWeight);
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _updateReps() {
    widget.exerciseSet.reps = int.tryParse(_repsController.text) ?? 0;
  }

  void _updateWeight() {
    widget.exerciseSet.weight = int.tryParse(_weightController.text) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isCompleted ? const Color(0xFF11664a) : Colors.transparent,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          widget.onSetDismissedCallback(widget.setNumber);
        },
        background: const DismissBackground(),
        child: Row(
          children: [
            Expanded(flex: 2, child: SetNumberDisplay(setNumber: widget.setNumber)),
            Expanded(
              flex: 4,
              child: Text(
                widget.exerciseSet.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(flex: 5, child: WeightInput(controller: _weightController, startingWeight: widget.exerciseSet.weight)),
            Expanded(flex: 5, child: RepsInput(controller: _repsController, startingReps: widget.exerciseSet.reps)),
            Expanded(
              flex: 3,
              child: CompletionIcon(
                isLocked: widget.isLocked,
                isCompleted: _isCompleted,
                onPressed: () {
                  setState(() {
                    if (!widget.isLocked) _isCompleted = !_isCompleted;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}