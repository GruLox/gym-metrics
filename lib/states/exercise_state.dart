import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';

class ExerciseState with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  ExerciseState() {
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    final QuerySnapshot querySnapshot = await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('exercises')
        .orderBy('nameLowercase')
        .get();

    _exercises = querySnapshot.docs.map((doc) {
      final dynamic data = doc.data();
      return Exercise(
        id: doc.id,
        name: data['name'],
        nameLowercase: data['nameLowercase'],
        muscleGroup: MuscleGroupExtension.fromString(data['muscleGroup']),
        bestWeightSet: data['bestWeightSet'] != null
            ? ExerciseSet.fromMap(data['bestWeightSet'])
            : null,
        bestRepsSet: data['bestRepsSet'] != null
            ? ExerciseSet.fromMap(data['bestRepsSet'])
            : null,
        bestOneRepMaxSet: data['bestOneRepMaxSet'] != null
            ? ExerciseSet.fromMap(data['bestOneRepMaxSet'])
            : null,
      );
    }).toList();

    notifyListeners();
  }

  Future<void> addExercise(Exercise exercise) async {
    final docRef = _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('exercises')
        .doc(); // Generate a new document reference with a unique ID

    exercise.nameLowercase = exercise.name.toLowerCase();

    exercise.id = docRef.id;

    await docRef.set({
      'id': exercise.id,
      'name': exercise.name,
      'nameLowercase': exercise.nameLowercase,
      'muscleGroup': exercise.muscleGroup.muscleGroupToString(),
    }); // Use set method to add the document with the specified ID

    fetchExercises();
  }

  Future<void> removeExercise(int index) async {
    final docId = _exercises[index].id;
    await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('exercises')
        .doc(docId)
        .delete();
    fetchExercises();
  }

  Future<void> updatePRs(Exercise exercise) async {
    final docRef = _db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('exercises')
        .doc(exercise.id);

    await docRef.update({
      'bestWeightSet': exercise.bestWeightSet?.toMap(),
      'bestRepsSet': exercise.bestRepsSet?.toMap(),
      'bestOneRepMaxSet': exercise.bestOneRepMaxSet?.toMap(),
    });
  }
}
