import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/workout_plan_card.dart';

class WorkoutPlansList extends StatelessWidget {
  final List<WorkoutPlan> workoutPlans;
  final Function(int) onWorkoutDeleted;
  final void Function() onWorkoutUpdated;

  const WorkoutPlansList({
    Key? key,
    required this.workoutPlans,
    required this.onWorkoutDeleted,
    required this.onWorkoutUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (workoutPlans.isEmpty) {
      return const Center(
        child: Text('No workout plans found.'),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 0.0),
      itemCount: workoutPlans.length,
      itemBuilder: (context, index) {
        return WorkoutPlanCard(
          workoutPlan: workoutPlans[index],
          onWorkoutDeletedCallback: () => onWorkoutDeleted(index),
          onWorkoutUpdatedCallback: onWorkoutUpdated,
        );
      },
    );
  }
}