import 'package:flutter/material.dart';

class AddExerciseHeader extends StatelessWidget {
  const AddExerciseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Add Exercise',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30.0, color: Colors.white),
    );
  }
}