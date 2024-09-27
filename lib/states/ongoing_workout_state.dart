import 'package:flutter/material.dart';
import 'package:gym_metrics/models/workout_plan.dart';

class OngoingWorkoutState with ChangeNotifier {
  WorkoutPlan? _ongoingWorkout;

  WorkoutPlan? get ongoingWorkout => _ongoingWorkout;

  void startWorkout(WorkoutPlan workoutPlan) {
    print('Starting workout: ${workoutPlan.name}');
    _ongoingWorkout = workoutPlan;
    notifyListeners();
  }

  void endWorkout() {
    print ('Ending workout: ${_ongoingWorkout!.name}');
    _ongoingWorkout = null;
    notifyListeners();
  }
}