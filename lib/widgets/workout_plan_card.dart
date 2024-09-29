import 'dart:io';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class WorkoutPlanCard extends StatefulWidget {
  const WorkoutPlanCard({
    super.key,
    required this.workoutPlan,
    required this.onWorkoutDeletedCallback,
    required this.onWorkoutUpdatedCallback,
  });

  final WorkoutPlan workoutPlan;
  final void Function() onWorkoutDeletedCallback;
  final void Function() onWorkoutUpdatedCallback;

  @override
  State<WorkoutPlanCard> createState() => _WorkoutPlanCardState();
}

class _WorkoutPlanCardState extends State<WorkoutPlanCard> {
  List<Widget> sets = [];
  DateTime? lastPerformed;

  CollectionReference workoutPlans = db
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('workoutPlans');

  @override
  void initState() {
    super.initState();
    getSets();
    fetchLastPerformedDate();
  }

  void getSets() {
    sets = [];
    for (var set in widget.workoutPlan.exerciseList) {
      sets.add(
        Text(
          '${set.exercise.name} x ${set.sets.length}',
          style: const TextStyle(color: Colors.grey),
        ),
      );
    }
  }

  void fetchLastPerformedDate() {
    final finishedWorkoutState =
        Provider.of<FinishedWorkoutState>(context, listen: false);
    lastPerformed =
        finishedWorkoutState.getLastPerformedDate(widget.workoutPlan.name);
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
    try {
      // Query for the document ID using a field that uniquely identifies the workout plan
      QuerySnapshot querySnapshot = await workoutPlans
          .where('name', isEqualTo: widget.workoutPlan.name)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there are no duplicate names)
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String docId = documentSnapshot.id;

        // Delete the workout plan
        await workoutPlans.doc(docId).delete();

        // Optionally, you can show a snackbar or perform other actions after successful deletion
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout plan deleted'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout plan does not exist'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the deletion process
      print('Error deleting workout plan: $e');
    }
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
                          // Navigate to the edit workout plan screen
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
                          bool confirmDelete = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if (Platform.isIOS) {
                                return CupertinoAlertDialog(
                                  title: const Text('Confirm Delete'),
                                  content: const Text(
                                      'Are you sure you want to delete this workout plan?'),
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
                                  content: const Text(
                                      'Are you sure you want to delete this workout plan?'),
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
                          if (confirmDelete == true) {
                            await deleteWorkoutPlan();
                            widget.onWorkoutDeletedCallback();
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
