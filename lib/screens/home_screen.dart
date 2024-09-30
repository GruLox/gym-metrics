import 'package:flutter/material.dart';
import 'package:gym_metrics/constants.dart';
import 'package:gym_metrics/models/weekly_workout_statistics_data.dart';
import 'package:gym_metrics/states/finished_workout_state.dart';
import 'package:gym_metrics/states/user_state.dart';
import 'package:gym_metrics/states/ongoing_workout_state.dart';
import 'package:gym_metrics/widgets/chart_card.dart';
import 'package:gym_metrics/widgets/workouts_per_week_chart.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final finishedWorkoutState = Provider.of<FinishedWorkoutState>(context);
    final countOfWorkouts = finishedWorkoutState.finishedWorkouts.length;
    final username = userState.username;
    final List<WeeklyWorkoutStatisticsData> workoutsPerWeek =
        finishedWorkoutState.finishedWorkoutsPerWeek.reversed
            .toList(); // Reverse the list
    final List<DateTime> dates =
        workoutsPerWeek.map((data) => data.date).toList();

    final List<BarChartGroupData> barGroups = workoutsPerWeek
        .asMap()
        .entries
        .map(
          (entry) => BarChartGroupData(
            x: entry.key, // Use the index as the x value
            barRods: [
              BarChartRodData(
                toY: entry.value.count.toDouble(),
                color: Colors.blue,
              ),
            ],
          ),
        )
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/settings'),
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
                          username,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Text('$countOfWorkouts workouts'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text('DASHBOARD'),
                const SizedBox(height: 20.0),
                ChartCard(
                  title: 'Workouts per week',
                  chart: SizedBox(
                    height: 200.0, // Set a specific height for the chart
                    child: WorkoutsPerWeekChart(
                        barGroups: barGroups, dates: dates),
                  ),
                ),
              ],
            ),
          ),
          Consumer<OngoingWorkoutState>(
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
                      Text(
                        'Ongoing Workout: ${ongoingWorkout.name}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromARGB(255, 24, 34, 48),
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
          ),
        ],
      ),
    );
  }
}
