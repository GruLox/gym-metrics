import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/states/workout_plan_state.dart';

class WorkoutPlanCard extends StatefulWidget {
  const WorkoutPlanCard({
    super.key,
    required this.workoutPlan,
    required this.onWorkoutUpdatedCallback,
  });

  final WorkoutPlan workoutPlan;
  final void Function() onWorkoutUpdatedCallback;

  @override
  State<WorkoutPlanCard> createState() => _WorkoutPlanCardState();
}

class _WorkoutPlanCardState extends State<WorkoutPlanCard> {
  List<Widget> sets = [];
  DateTime? lastPerformed;

  @override
  void initState() {
    super.initState();
    getSets();
    fetchLastPerformedDate();
  }

  void getSets() {
    sets = widget.workoutPlan.exerciseList.map((set) {
      return Text(
        '${set.exercise.name} x ${set.sets.length}',
        style: const TextStyle(color: Colors.grey),
      );
    }).toList();
  }

  void fetchLastPerformedDate() async {
    final finishedWorkoutState =
        Provider.of<FinishedWorkoutState>(context, listen: false);
    lastPerformed =
        await finishedWorkoutState.getLastPerformedDate(widget.workoutPlan.name);
    setState(() {});
  }

  String getFormattedLastPerformedDate() {
    if (lastPerformed == null) {
      return 'Last performed: N/A';
    }

    final now = DateTime.now();
    final difference = now.difference(lastPerformed!);

    if (difference.inDays >= 1) {
      return 'Last performed: ${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return 'Last performed: ${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return 'Last performed: ${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Last performed: just now';
    }
  }

  Future<void> deleteWorkoutPlan() async {
    final workoutPlanState = Provider.of<WorkoutPlanState>(context, listen: false);
    await workoutPlanState.deleteWorkoutPlan(widget.workoutPlan.id);
  }

  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this workout plan?'),
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
            content: const Text('Are you sure you want to delete this workout plan?'),
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/workout-plan-start',
        arguments: widget.workoutPlan,
      ),
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.workoutPlan.name,
                    style: const TextStyle(fontSize: 20.0)),
                PopupMenuButton(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/edit-workout-plan',
                            arguments: widget.workoutPlan,
                          );
                          widget.onWorkoutUpdatedCallback();
                        },
                        child: const Text('Edit'),
                      ),
                      PopupMenuItem(
                        onTap: () async {
                          bool confirmDelete = await showDeleteConfirmationDialog(context);
                          if (confirmDelete) {
                            await deleteWorkoutPlan();
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
              getFormattedLastPerformedDate(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sets,
            )
          ],
        ),
      ),
    );
  }
}