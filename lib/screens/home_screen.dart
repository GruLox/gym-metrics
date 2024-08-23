import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/state/user_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = UserState();
    final user = userState.user;

    return Scaffold(
      body: Container(
        margin: kContainerMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'GymMetrics',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
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
                      user?.displayName ?? 'Guest',
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const Text('154 workouts'),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text('DASHBOARD'),
          ],
        ),
      ),
    );
  }
}
