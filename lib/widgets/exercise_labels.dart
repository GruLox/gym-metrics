import 'package:flutter/material.dart';

class ExerciseLabels extends StatelessWidget {
  const ExerciseLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.white),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FixedColumnWidth(10.0),
        2: FlexColumnWidth(4),
        3: FlexColumnWidth(5),
        4: FixedColumnWidth(10.0),
        5: FlexColumnWidth(5),
        6: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            const Text(
              'SET',
              style: TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox.shrink(),
            const Text(
              'PREVIOUS',
              style: TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'KG',
              style: TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox.shrink(),
            const Text(
              'REPS',
              style: TextStyle(
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
            Container(), // Empty container for spacing
          ],
        ),
      ],
    );
  }
}
