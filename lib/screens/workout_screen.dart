import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/workout_plan_card.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  late List<WorkoutPlan> workoutPlans;
  late Future<List<WorkoutPlan>> workoutPlansFuture;

  @override
  void initState() {
    super.initState();
    workoutPlansFuture = getWorkoutPlans();
  }

  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final QuerySnapshot querySnapshot = await db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('workoutPlans')
        .get();

    workoutPlans = querySnapshot.docs.map((doc) {
      final dynamic data = doc.data();
      final WorkoutPlan workoutPlan = WorkoutPlan.fromMap(data);
      return workoutPlan;
    }).toList();

    return workoutPlans;
  }

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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/active_workout', arguments: 
                       WorkoutPlan(
                        name: 'Quick Start',
                        exerciseList: [],
                      ),
                    );
                  },
                  child: const Text(
                    'START AN EMPTY WORKOUT',
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
                  onPressed: () async {
                    WorkoutPlan? addedWorkoutPlan = await Navigator.pushNamed(
                      context,
                      '/add-workout-plan',
                    ) as WorkoutPlan?;
                    if (addedWorkoutPlan != null) {
                      setState(() {
                        workoutPlans.add(addedWorkoutPlan);
                      });
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: getWorkoutPlans(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 0.0),
                      itemCount: workoutPlans.length,
                      itemBuilder: (context, index) {
                        return WorkoutPlanCard(
                          workoutPlan: workoutPlans[index],
                          onWorkoutDeletedCallback: () {
                            setState(() {
                              workoutPlans.removeAt(index);
                            });
                          },
                          onWorkoutUpdatedCallback: () {
                            setState(() {
                              getWorkoutPlans();
                            });
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
