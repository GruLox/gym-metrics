import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';

class AddExerciseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddExerciseButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Add Exercise',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}