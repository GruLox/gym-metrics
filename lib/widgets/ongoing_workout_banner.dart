import 'package:flutter/material.dart';
import 'package:gym_metrics/states/ongoing_workout_state.dart';
import 'package:provider/provider.dart';


class OngoingWorkoutBanner extends StatelessWidget {
  const OngoingWorkoutBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OngoingWorkoutState>(
      builder: (context, ongoingWorkoutState, child) {
        final ongoingWorkout = ongoingWorkoutState.ongoingWorkout;
        if (ongoingWorkout == null) {
          return SizedBox.shrink();
        }
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: const Color.fromARGB(255, 24, 34, 48),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Ongoing Workout: ${ongoingWorkout.name}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 24, 34, 48),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/active_workout',
                        arguments: ongoingWorkout);
                  },
                  child: const Text('Resume'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}