import 'package:flutter/material.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/widgets/history_details.dart';

class HistoryCard extends StatelessWidget {
  final FinishedWorkout finishedWorkout;

  const HistoryCard({super.key, required this.finishedWorkout});

  String toHumanReadableDate(DateTime date) {
    const MONTHS =  <int, String>{
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };

    final month = MONTHS[date.month];

    return '$month ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    // print(finishedWorkout.toMap());
    print('${finishedWorkout.exerciseList[0].exercise.id} ${finishedWorkout.exerciseList[1].exercise.name}');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5.0),
          Text(
            finishedWorkout.name,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5.0),
          Text(
            toHumanReadableDate(finishedWorkout.date),
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5.0),
          HistoryDetails(
            duration: finishedWorkout.duration,
            totalWeightLifted: finishedWorkout.totalWeightLifted,
            prs: finishedWorkout.prs,
          ),
        ],
      ),
    );
  }
}
