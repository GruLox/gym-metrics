import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/widgets/history_details.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'dart:io';

class HistoryCard extends StatelessWidget {
  final FinishedWorkout finishedWorkout;

  HistoryCard({super.key, required this.finishedWorkout});

  String toHumanReadableDate(DateTime date) {
    final month = kMonths[date.month];
    return '$month ${date.day}';
  }

  Future<void> updateFinishedWorkout(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      '/edit-finished-workout',
      arguments: finishedWorkout,
    ).then((_) {
      Provider.of<FinishedWorkoutState>(context, listen: false).fetchFinishedWorkouts();
    });
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this finished workout?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this finished workout?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        }
      },
    );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  finishedWorkout.name,
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton(
                padding: EdgeInsets.zero,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () async {
                        await updateFinishedWorkout(context);
                      },
                      child: const Text('Edit'),
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        bool confirmDelete = await showDeleteConfirmationDialog(context);
                        if (confirmDelete) {
                          await Provider.of<FinishedWorkoutState>(context, listen: false)
                              .removeFinishedWorkout(finishedWorkout.id);
                          Provider.of<FinishedWorkoutState>(context, listen: false).fetchFinishedWorkouts();
                        }
                      },
                      child: const Text('Delete'),
                    ),
                  ];
                },
                child: const Icon(Icons.more_vert),
              ),
            ],
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
                .map((exercise) => ExerciseRow(exercise: exercise))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ExerciseRow extends StatelessWidget {
  final WeightliftingSet exercise;

  const ExerciseRow({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${exercise.sets.length} x ${exercise.exercise.name}',
            style: const TextStyle(fontSize: 14.0),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        Text(
          exercise.bestSet.toString(),
          style: const TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }
}