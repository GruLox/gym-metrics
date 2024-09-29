import 'package:flutter/material.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OngoingWorkoutState with ChangeNotifier {
  WorkoutPlan? _ongoingWorkout;

  WorkoutPlan? get ongoingWorkout => _ongoingWorkout;

  OngoingWorkoutState() {
    _loadOngoingWorkout();
  }

  void startWorkout(WorkoutPlan workoutPlan) {
    _ongoingWorkout = workoutPlan;
    _saveOngoingWorkout();
    notifyListeners();
  }

  void endWorkout() {
    _ongoingWorkout = null;
    _removeOngoingWorkout();
    notifyListeners();
  }

  void updateExerciseSet(int exerciseIndex, int setIndex, ExerciseSet updatedSet) {
    if (_ongoingWorkout != null) {
      _ongoingWorkout!.exerciseList[exerciseIndex].sets[setIndex] = updatedSet;
      _saveOngoingWorkout();
      notifyListeners();
    }
  }

  Future<void> _saveOngoingWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    if (_ongoingWorkout != null) {
      prefs.setString('ongoingWorkout', jsonEncode(_ongoingWorkout!.toMap()));
    }
  }

  Future<void> _loadOngoingWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    final String? workoutJson = prefs.getString('ongoingWorkout');
    if (workoutJson != null) {
      _ongoingWorkout = WorkoutPlan.fromMap(jsonDecode(workoutJson));
      notifyListeners();
    }
  }

  Future<void> _removeOngoingWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('ongoingWorkout');
  }
}