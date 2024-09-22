import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';

class ExerciseHistoryCard extends StatelessWidget {
  final FinishedWorkout finishedWorkout;
  final FinishedWorkoutState finishedWorkoutState = FinishedWorkoutState();
  final int setIndex;

  ExerciseHistoryCard(
      {super.key, required this.finishedWorkout, required this.setIndex});

  String toHumanReadableDate(DateTime date) {
    final month = kMonths[date.month];
    final dayName = kDays[date.weekday];
    final time = '${date.hour}:${date.minute}';

    return '$dayName, $month ${date.day}, ${date.year}, $time';
  }

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5.0),
          Text(
            toHumanReadableDate(finishedWorkout.date),
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          const Row(
            children: [
              Text(
                'Sets Performed',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '1RM',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Column(
            children: finishedWorkout.exerciseList[setIndex].sets
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key + 1;
              var set = entry.value;
              return Row(
                children: [
                  Text(
                    '$index   ${set.weight} x ${set.reps}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                  const Spacer(),
                  Text(
                    set.oneRepMax.toString(),
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
