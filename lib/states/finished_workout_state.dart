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
    try {
      final workoutSnapshot = await _db
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .collection('workouts')
          .get();

      _finishedWorkouts =
          await Future.wait(workoutSnapshot.docs.map((workoutDoc) async {
        final workoutData = workoutDoc.data();

        // Check if required fields exist
        if (!workoutData.containsKey('name') ||
            !workoutData.containsKey('date') ||
            !workoutData.containsKey('duration')) {
          throw Exception('Invalid workout data');
        }

        final exerciseList = await _fetchExerciseList(workoutDoc.reference);

        return FinishedWorkout(
          id: workoutDoc.id,
          name: workoutData['name'] as String,
          exerciseList: exerciseList,
          workoutNote: workoutData['workoutNote'] as String?,
          date: (workoutData['date'] as Timestamp).toDate(),
          duration: workoutData['duration'] as int? ?? 0,
        );
      }).toList());

      notifyListeners();
    } catch (e) {
      // Handle errors appropriately
      print('Error fetching finished workouts: $e');
    }
  }


  Future<void> addFinishedWorkout(FinishedWorkout workout) async {
    final docRef = _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workouts')
        .doc();
    workout.id = docRef.id;
    await docRef.set({
      'name': workout.name,
      'date': workout.date,
      'duration': workout.duration,
    });

    for (var weightLiftingSet in workout.exerciseList) {
      final exerciseDocRef = docRef.collection('exerciseList').doc();
      await exerciseDocRef.set({
        'name': weightLiftingSet.exercise.name,
        'muscleGroup':
            weightLiftingSet.exercise.muscleGroup.muscleGroupToString(),
      });

      for (var set in weightLiftingSet.sets) {
        final setDocRef = exerciseDocRef.collection('sets').doc();
        await setDocRef.set({
          'weight': set.weight,
          'reps': set.reps,
          'pr': set.isPR,
        });
      }
    }

    fetchFinishedWorkouts();
  }

  Future<void> removeFinishedWorkout(int index) async {
    final docId = _finishedWorkouts[index].id;
    await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('workouts')
        .doc(docId)
        .delete();
    fetchFinishedWorkouts();
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
}

  Future<List<WeightliftingSet>> _fetchExerciseList(
      DocumentReference workoutRef) async {
    final exercisesSnapshot = await workoutRef.collection('exerciseList').get();
    return Future.wait(exercisesSnapshot.docs.map((exerciseDoc) async {
      final exerciseData = exerciseDoc.data();

      // Check if required fields exist
      if (!exerciseData.containsKey('name') ||
          !exerciseData.containsKey('muscleGroup')) {
        throw Exception('Invalid exercise data');
      }

      final setsList = await _fetchSets(exerciseDoc.reference);

      return WeightliftingSet(
        exercise: Exercise(
          id: exerciseDoc.id,
          name: exerciseData['name'] as String,
          muscleGroup: MuscleGroupExtension.fromString(
              exerciseData['muscleGroup'] as String)!,
        ),
        sets: setsList,
      );
    }).toList());
  }

  Future<List<ExerciseSet>> _fetchSets(DocumentReference exerciseRef) async {
    final setsSnapshot = await exerciseRef.collection('sets').get();
    return setsSnapshot.docs.map((setDoc) {
      final setData = setDoc.data();

      // Check if required fields exist
      if (!setData.containsKey('reps') ||
          !setData.containsKey('weight') ||
          !setData.containsKey('pr')) {
        throw Exception('Invalid set data');
      }

      return ExerciseSet(
        reps: setData['reps'] as int,
        weight: setData['weight'] as int,
        isPR: setData['pr'] as bool,
      );
    }).toList();
  }