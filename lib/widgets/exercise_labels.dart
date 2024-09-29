import 'package:flutter/material.dart';

class ExerciseLabels extends StatelessWidget {
  const ExerciseLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(5),
        2: FlexColumnWidth(5),
        3: FlexColumnWidth(5),
        4: FlexColumnWidth(3),
      },
      children: const [
        TableRow(
          children: [
            Center(
              child: Text(
                'SET',
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'PREVIOUS',
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'KG',
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Text(
                'REPS',
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}