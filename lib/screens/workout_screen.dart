import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/screens/add_workout_plan_screen.dart';
import 'package:gym_metrics/widgets/workout_plan_card.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: kContainerMargin.copyWith(top: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout',
              style: TextStyle(fontSize: 30.0),
            ),
            const SizedBox(height: 30.0),
            const Text(
              'QUICK START',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10.0),
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
                child: const Text(
                  'Start an empty workout',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MY TEMPLATES',
                  style: TextStyle(color: Colors.grey),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddWorkoutPlanScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const WorkoutPlanCard(),
            const SizedBox(height: 20.0),
            const WorkoutPlanCard(),
          ],
        ),
      ),
    );
  }
}
