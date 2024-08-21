import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/exercise_card.dart';

class WorkoutPlanStartScreen extends StatefulWidget {
  const WorkoutPlanStartScreen({
    super.key,
  });

  @override
  State<WorkoutPlanStartScreen> createState() => _WorkoutPlanStartScreenState();
}

class _WorkoutPlanStartScreenState extends State<WorkoutPlanStartScreen> {
  @override
  Widget build(BuildContext context) {
    WorkoutPlan workoutPlan =
        ModalRoute.of(context)!.settings.arguments as WorkoutPlan;

    return Scaffold(
      body: Container(
        margin: kContainerMargin.copyWith(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(),
            const SizedBox(height: 20.0),
            Text(workoutPlan.name, style: const TextStyle(fontSize: 30.0)),
            const SizedBox(height: 20.0),
            const Text(
              'Last performed: Yesterday',
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 0.0),
                itemCount: workoutPlan.exerciseList.length,
                itemBuilder: ((context, index) {
                  return ExerciseCard(
                    name: workoutPlan.exerciseList[index].exercise.name,
                    muscleGroup:
                        workoutPlan.exerciseList[index].exercise.muscleGroup,
                  );
                }),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
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
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/active_workout', arguments: workoutPlan);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'START WORKOUT',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
