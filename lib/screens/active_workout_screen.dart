import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/exercise_set.dart';
import 'package:gym_metrics/models/weightlifting_set.dart';
import 'package:gym_metrics/models/workout_plan.dart';
import 'package:gym_metrics/widgets/full_workout_plan.dart';

class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  List<WeightliftingSet> exercises = [];
  final ValueNotifier<bool> _isMinimizedNotifier = ValueNotifier(false);

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

  @override
  Widget build(BuildContext context) {
    final WorkoutPlan workoutPlan =
        ModalRoute.of(context)?.settings.arguments as WorkoutPlan;
            
    exercises = workoutPlan.exerciseList.reversed.toList();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('FINISH',
                    style: TextStyle(fontSize: 18.0, color: kPrimaryColor)),
              ),
            ],
            leading: GestureDetector(
              onTap: () {
                _isMinimizedNotifier.value = !_isMinimizedNotifier.value;
                Navigator.pushNamed(context, '/',
                    arguments: {
                      'isMinimizedNotifier': _isMinimizedNotifier,
                      'workoutPlan': workoutPlan,
                    });
              },
              child: const Icon(Icons.expand_more, size: 40.0),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 30.0,
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 0.0, left: 20.0, right: 20.0, top: 10.0),
                  child: Text(
                    workoutPlan.name,
                    style: const TextStyle(fontSize: 30.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                FullWorkoutPlan(
                  exercises: exercises,
                  onSetAdded: onSetAdded,
                  onSetRemoved: onSetRemoved,
                  onExerciseRemoved: onExerciseRemoved,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
