import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/workout_plan.dart';

class QuickStartButton extends StatelessWidget {
  const QuickStartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/active_workout',
            arguments: WorkoutPlan(
              id: '',
              name: 'Quick Start',
              exerciseList: [],
            ),
          );
        },
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
          'START AN EMPTY WORKOUT',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
