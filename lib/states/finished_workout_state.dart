import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_metrics/enums/muscle_group.dart';
import 'package:gym_metrics/models/exercise.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/finished_workout.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';

class FinishedWorkoutState with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<FinishedWorkout> _finishedWorkouts = [];

  List<FinishedWorkout> get finishedWorkouts => _finishedWorkouts;

  FinishedWorkoutState() {
    fetchFinishedWorkouts();
  }

  Future<void> fetchFinishedWorkouts() async {
  final workoutSnapshot = await _db
      .collection('users')
      .doc(_auth.currentUser?.uid)
      .collection('workouts')
      .orderBy('date', descending: true)
      .get();

  _finishedWorkouts = workoutSnapshot.docs.map((workoutDoc) {
    final workoutData = workoutDoc.data();

    // Check if required fields exist
    if (!workoutData.containsKey('name') ||
        !workoutData.containsKey('date') ||
        !workoutData.containsKey('duration') ||
        !workoutData.containsKey('exerciseList')) {
      throw Exception('Invalid workout data');
    }

    // Map exerciseList field directly
    final exerciseList = (workoutData['exerciseList'] as List<dynamic>).map((exerciseData) {
      final exercise = exerciseData['exercise'];
      return WeightliftingSet(
        exercise: Exercise(
          id: exercise['id'] as String,
          name: exercise['name'] as String,
          muscleGroup: MuscleGroupExtension.fromString(exercise['muscleGroup'] as String),
          bestOneRepMaxSet: exercise['bestOneRepMaxSet'] != null ? ExerciseSet(
            reps: exercise['bestOneRepMaxSet']['reps'] as int,
            weight: exercise['bestOneRepMaxSet']['weight'] as int,
            isPR: exercise['bestOneRepMaxSet']['pr'] as bool,
          ) : null,
          bestRepsSet: exercise['bestRepsSet'] != null ? ExerciseSet(
            reps: exercise['bestRepsSet']['reps'] as int,
            weight: exercise['bestRepsSet']['weight'] as int,
            isPR: exercise['bestRepsSet']['pr'] as bool,
          ) : null,
          bestWeightSet: exercise['bestWeightSet'] != null ? ExerciseSet(
            reps: exercise['bestWeightSet']['reps'] as int,
            weight: exercise['bestWeightSet']['weight'] as int,
            isPR: exercise['bestWeightSet']['pr'] as bool,
          ) : null,
        ),
        sets: (exerciseData['sets'] as List<dynamic>).map((setData) {
          return ExerciseSet(
            reps: setData['reps'] as int,
            weight: setData['weight'] as int,
            isPR: setData['pr'] as bool,
          );
        }).toList(),
      );
    }).toList();

    return FinishedWorkout(
      id: workoutDoc.id,
      name: workoutData['name'] as String,
      exerciseList: exerciseList,
      workoutNote: workoutData['workoutNote'] as String?,
      date: (workoutData['date'] as Timestamp).toDate(),
      duration: workoutData['duration'] as int? ?? 0,
    );
  }).toList();

  notifyListeners();
}

  Future<void> addFinishedWorkout(FinishedWorkout finishedWorkout) async {
    final docRef = _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workouts')
        .doc(); // Generate a new document reference with a unique ID
    finishedWorkout.id = docRef.id; // Set the ID in the FinishedWorkout object
    await docRef.set(finishedWorkout
        .toMap()); // Use set method to add the document with the specified ID
    fetchFinishedWorkouts();
  }

  Future<void> removeFinishedWorkout(String id) async {
    try {
      final docId =
          _finishedWorkouts.firstWhere((workout) => workout.id == id).id;
      _finishedWorkouts.removeWhere((workout) => workout.id == id);
      await _db
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('workouts')
          .doc(docId)
          .delete();

      // Remove best sets from exercises and update them in the database
      for (var workout in _finishedWorkouts) {
        for (var weightLiftingSet in workout.exerciseList) {
          for (var set in weightLiftingSet.sets) {
            await weightLiftingSet.exercise.updateBestSets(set);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      print('Error removing finished workout: $e');
    }
  }

  Future<void> updateFinishedWorkout(FinishedWorkout workout) async {
    final docId = workout.id;
    await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workouts')
        .doc(docId)
        .update(workout.toMap());
    fetchFinishedWorkouts();
  }

  Future<void> updateBestSetsOnSave(FinishedWorkout workout) async {
    for (var weightLiftingSet in workout.exerciseList) {
      for (var set in weightLiftingSet.sets) {
        await weightLiftingSet.exercise.updateBestSets(set);
      }
    }
  }
}