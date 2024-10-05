import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_metrics/widgets/chart_card.dart';
import 'package:provider/provider.dart';
import '../states/finished_workout_state.dart';
import '../models/weekly_workout_statistics_data.dart';
import 'workouts_per_week_chart.dart';

class HomeScreenWorkoutChart extends StatelessWidget {
  const HomeScreenWorkoutChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final finishedWorkoutState = Provider.of<FinishedWorkoutState>(context);
    final List<WeeklyWorkoutStatisticsData> workoutsPerWeek =
        finishedWorkoutState.finishedWorkoutsPerWeek.reversed.toList();
    final List<DateTime> dates =
        workoutsPerWeek.map((data) => data.date).toList();

    final List<BarChartGroupData> barGroups = workoutsPerWeek
        .asMap()
        .entries
        .map(
          (entry) => BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.count.toDouble(),
                color: Colors.blue,
              ),
            ],
          ),
        )
        .toList();

    return ChartCard(
      title: 'Workouts per week',
      chart: SizedBox(
        height: 200.0,
        child: WorkoutsPerWeekChart(barGroups: barGroups, dates: dates),
      ),
    );
  }
}
