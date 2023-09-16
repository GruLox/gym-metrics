import 'package:flutter/material.dart';

class ExerciseLabels extends StatelessWidget {
  const ExerciseLabels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'SET',
            style: TextStyle(
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 3,
          child: Text(
            'PREVIOUS',
            style: TextStyle(
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'KG',
            style: TextStyle(
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 4,
          child: Text(
            'REPS',
            style: TextStyle(
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(), // Empty container for spacing
        ),
      ],
    );
  }
}
