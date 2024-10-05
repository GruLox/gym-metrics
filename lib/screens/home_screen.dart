import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/widgets/home_screen_header.dart';
import 'package:gym_metrics/widgets/home_screen_user_info.dart';
import 'package:gym_metrics/widgets/home_screen_workout_chart.dart';
import 'package:gym_metrics/widgets/ongoing_workout_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: kContainerMargin,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                HomeScreenHeader(),
                SizedBox(height: 20.0),
                HomeScreenUserInfo(),
                SizedBox(height: 20.0),
                Text('DASHBOARD'),
                SizedBox(height: 20.0),
                HomeScreenWorkoutChart(),
              ],
            ),
          ),
          const OngoingWorkoutBanner(),
        ],
      ),
    );
  }
}

