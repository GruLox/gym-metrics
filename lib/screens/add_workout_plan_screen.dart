import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/full_workout_plan.dart';

final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class AddWorkoutPlanScreen extends StatefulWidget {
  const AddWorkoutPlanScreen({
    super.key,
  });

  @override
  State<AddWorkoutPlanScreen> createState() => _AddWorkoutPlanScreenState();
}

class _AddWorkoutPlanScreenState extends State<AddWorkoutPlanScreen> {
  String muscleGroup = 'None';
  final TextEditingController _nameController = TextEditingController();
  List<WeightliftingSet> exercises = [];

  void onSetAdded(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].addSet(weightliftingSet);
    });
  }

  void onSetRemoved(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].removeSet(weightliftingSet);
    });
  }

  void onExerciseRemoved(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  void uploadWorkoutPlan(WorkoutPlan addedWorkoutPlan) async {
    await db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('workoutPlans')
        .add(addedWorkoutPlan.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Create a New Plan', style: TextStyle(fontSize: 25.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              WorkoutPlan addedWorkoutPlan = WorkoutPlan(
                name: _nameController.text,
                exerciseList: exercises.reversed.toList(),
              );
              uploadWorkoutPlan(addedWorkoutPlan);
              Navigator.pop(context, addedWorkoutPlan);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 30.0,
        ),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.black),
                decoration: kWhiteInputDecoration.copyWith(
                  hintText: 'Workout Name',
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            FullWorkoutPlan(
              exercises: exercises,
              onSetAdded: onSetAdded,
              onSetRemoved: onSetRemoved,
              onExerciseRemoved: onExerciseRemoved,
              isLocked: true,
            ),
          ],
        ),
      ),
    );
  }
}

