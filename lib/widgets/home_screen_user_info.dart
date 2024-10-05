import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/states/user_state.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';


class HomeScreenUserInfo extends StatelessWidget {
  const HomeScreenUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final finishedWorkoutState = Provider.of<FinishedWorkoutState>(context);
    final countOfWorkouts = finishedWorkoutState.finishedWorkouts.length;
    final username = userState.username;

    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: kAvatarBackgroundColor,
          radius: 30.0,
          child: Icon(
            Icons.person,
            size: 30.0,
          ),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text('$countOfWorkouts workouts'),
          ],
        ),
      ],
    );
  }
}