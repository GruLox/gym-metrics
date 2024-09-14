import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/widgets/history_details.dart';

class HistoryCard extends StatelessWidget {
  final FinishedWorkout finishedWorkout;

  const HistoryCard({super.key, required this.finishedWorkout});

  String toHumanReadableDate(DateTime date) {
    final month = kMonths[date.month];

    return '$month ${date.day}';
  }

  @override
  Widget build(BuildContext context) {
    // print(finishedWorkout.toMap());
    // print(
    //     '${finishedWorkout.exerciseList[0].exercise.id} ${finishedWorkout.exerciseList[1].exercise.name}');

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
          const SizedBox(height: 10.0),
          const Row(
            children: [
              Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Best set',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Column(
            children: finishedWorkout.exerciseList
                .map((exercise) => Row(
                      children: [
                        Text(
                          '${exercise.sets.length} x ${exercise.exercise.name}',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const Spacer(),
                        Text(
                          exercise.bestSet.toString(),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
