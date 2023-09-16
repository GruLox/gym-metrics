import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class ExerciseTitle extends StatelessWidget {
  const ExerciseTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
