import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';

class MyTemplatesHeader extends StatelessWidget {
  const MyTemplatesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'MY TEMPLATES',
          style: TextStyle(color: Colors.grey),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            WorkoutPlan? addedWorkoutPlan = await Navigator.pushNamed(
              context,
              '/add-workout-plan',
            ) as WorkoutPlan?;
            if (addedWorkoutPlan != null) {
              (context as Element).markNeedsBuild();
            }
          },
        ),
      ],
    );
  }
}