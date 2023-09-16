import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/widgets/exercise_labels.dart';
import 'package:gym_metrics/widgets/exercise_set_row.dart';
import 'package:gym_metrics/widgets/exercise_title.dart';

class ExerciseContainer extends StatefulWidget {
  const ExerciseContainer({
    super.key,
    required this.title,
    this.isLocked = false,
  });

  final String title;
  final  bool isLocked;

  @override
  State<ExerciseContainer> createState() => _ExerciseContainerState();
}

class _ExerciseContainerState extends State<ExerciseContainer> {
  int setCount = 1;

  @override
  Widget build(BuildContext context) {
    List<ExerciseSetRow> setRows = [];

    for (int i = 0; i < setCount; i++) {
      setRows.add(
        ExerciseSetRow(
          isLocked: widget.isLocked,
          setNumber: i + 1,
        ),
      );
    }

    return SizedBox(
      height: setCount * 70.0 + 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          ExerciseTitle(title: widget.title),
          const SizedBox(height: 15.0),
          Column(
            children: [
              const ExerciseLabels(),
              ...setRows,
              TextButton(
                onPressed: () {
                  setState(() {
                    setCount++;
                  });
                },
                child: const Text(
                  'ADD SET',
                  style: TextStyle(fontSize: 16.0, color: kPrimaryColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
