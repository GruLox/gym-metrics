import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/widgets/exercise_labels.dart';
import 'package:gym_metrics/widgets/exercise_set_row.dart';
import 'package:gym_metrics/widgets/exercise_title.dart';

class ExerciseContainer extends StatefulWidget {
  const ExerciseContainer({
    super.key,
    required this.weightliftingSet,
    required this.index,
    required this.onSetAddedCallback,
    required this.onSetRemovedCallback,
    required this.onExerciseRemovedCallback,
    this.isLocked = false,
  });

  final bool isLocked;
  final WeightliftingSet weightliftingSet;
  final int index;
  final void Function(int index, ExerciseSet weightliftingSet)
      onSetAddedCallback;
  final void Function(int index, ExerciseSet weightliftingSet)
      onSetRemovedCallback;
  final void Function() onExerciseRemovedCallback;

  @override
  State<ExerciseContainer> createState() => _ExerciseContainerState();
}

class _ExerciseContainerState extends State<ExerciseContainer> {
  late int setCount;

  @override
  void initState() {
    super.initState();
    setCount = widget.weightliftingSet.sets.length;
  }

  @override
  void didUpdateWidget(covariant ExerciseContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.weightliftingSet.sets.length !=
        widget.weightliftingSet.sets.length) {
      setCount = widget.weightliftingSet.sets.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> setRows = [];

    for (int i = 0; i < setCount; i++) {
      setRows.add(
        TableRow(
          children: [
            ExerciseSetRow(
              isLocked: widget.isLocked,
              setNumber: i + 1,
              exerciseSet: widget.weightliftingSet.sets[i],
              onSetDismissedCallback: (int setNumber) {
                setState(() {
                  setCount--;
                  widget.onSetRemovedCallback(
                    widget.index,
                    widget.weightliftingSet.sets[setNumber - 1],
                  );
                });
              },
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: setCount * 70.0 + 130.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          ExerciseTitle(title: widget.weightliftingSet.exercise.name),
          const SizedBox(height: 15.0),
          Column(
            children: [
              const ExerciseLabels(),
              Table(
                border: TableBorder.all(color: Colors.white),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  2: FlexColumnWidth(4),
                  3: FlexColumnWidth(5),
                  5: FlexColumnWidth(5),
                  6: FlexColumnWidth(3),
                },
                children: setRows,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    setCount++;
                    widget.onSetAddedCallback(
                      widget.index,
                      ExerciseSet(),
                    );
                  });
                },
                child: const Text(
                  'ADD SET',
                  style: TextStyle(fontSize: 16.0, color: kPrimaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
