import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_metrics/models/workout_plan.dart';

class WorkoutPlanState with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<WorkoutPlan> _workoutPlans = [];

  List<WorkoutPlan> get workoutPlans => _workoutPlans;

  WorkoutPlanState() {
    fetchWorkoutPlans();
  }

  Future<void> fetchWorkoutPlans() async {
    final QuerySnapshot querySnapshot = await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workoutPlans')
        .get();

    _workoutPlans = querySnapshot.docs.map((doc) {
      final dynamic data = doc.data();
      return WorkoutPlan.fromMap(data)..id = doc.id;
    }).toList();

    notifyListeners();
  }

  Future<void> addWorkoutPlan(WorkoutPlan workoutPlan) async {
    final docRef = _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workoutPlans')
        .doc(); // Generate a new document reference with a unique ID

    workoutPlan.id = docRef.id; // Set the ID in the WorkoutPlan object

    await docRef.set(workoutPlan
        .toMap()); // Use set method to add the document with the specified ID

    fetchWorkoutPlans();
  }

  Future<void> removeWorkoutPlan(int index) async {
    final docId = _workoutPlans[index].id;
    await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workoutPlans')
        .doc(docId)
        .delete();
    fetchWorkoutPlans();
  }

  Future<void> updateWorkoutPlan(WorkoutPlan workoutPlan) async {
    final docId = workoutPlan.id;
    await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workoutPlans')
        .doc(docId)
        .update(workoutPlan.toMap());
    fetchWorkoutPlans();
  }
}
