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

class EditWorkoutPlanScreen extends StatefulWidget {
  const EditWorkoutPlanScreen({
    super.key,
  });

  @override
  State<EditWorkoutPlanScreen> createState() => _EditWorkoutPlanScreenState();
}

class _EditWorkoutPlanScreenState extends State<EditWorkoutPlanScreen> {
  String muscleGroup = 'None';
  final TextEditingController _nameController = TextEditingController();
  List<WeightliftingSet> exercises = [];

  CollectionReference workoutPlans = db
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('workoutPlans');

  void onSetAdded(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].addSet(weightliftingSet);
    });
  }

  void onExerciseRemoved(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  void onSetRemoved(int index, ExerciseSet weightliftingSet) {
    setState(() {
      exercises[index].removeSet(weightliftingSet);
    });
  }

  void updateWorkoutPlan(
      WorkoutPlan oldWorkoutPlan, WorkoutPlan updatedWorkoutPlan) async {
    try {
      QuerySnapshot querySnapshot = await workoutPlans
          .where('name', isEqualTo: oldWorkoutPlan.name)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (assuming there are no duplicate names)
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String docId = documentSnapshot.id;

        // Update the workout plan
        await workoutPlans.doc(docId).update(updatedWorkoutPlan.toMap());
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final WorkoutPlan workoutPlan =
        ModalRoute.of(context)!.settings.arguments as WorkoutPlan;
    _nameController.text = workoutPlan.name;
    exercises = workoutPlan.exerciseList.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Edit Workout Plan', style: TextStyle(fontSize: 25.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              WorkoutPlan updatedWorkoutPlan = WorkoutPlan(
                id: workoutPlan.id,
                name: _nameController.text,
                exerciseList: exercises.reversed.toList(),
                workoutNote: workoutPlan.workoutNote,
              );
              updateWorkoutPlan(workoutPlan, updatedWorkoutPlan);
              Navigator.pop(context, updatedWorkoutPlan);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 30.0,
        ),
        child: ListView(children: [
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
        ]),
      ),
    );
  }
}
