import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_metrics/utils/chart_utils.dart';
import 'package:intl/intl.dart';

class WorkoutsPerWeekChart extends StatelessWidget {
  final List<BarChartGroupData> barGroups;
  final List<DateTime> dates;

  const WorkoutsPerWeekChart({Key? key, required this.barGroups, required this.dates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: barGroups
                .map((group) => group.barRods.first.toY)
                .reduce((a, b) => a > b ? a : b) +
            1,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.blueAccent.withOpacity(0.8),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()} workouts',
                const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        titlesData: buildTitlesData(
            interval: 1,
            minY: 0,
            maxY: barGroups
                    .map((group) => group.barRods.first.toY)
                    .reduce((a, b) => a > b ? a : b) +
                1,
            dates: dates),
        gridData: buildGridData(),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        barGroups: barGroups,
      ),
    );
  }
}

FlTitlesData buildTitlesData({required double interval, required double minY, required double maxY, required List<DateTime> dates}) {
  return FlTitlesData(
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (value == minY || value == maxY) {
            return const SizedBox.shrink();
          }
          return Text(
            '${value.toInt()}',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          );
        },
        interval: interval,
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (value.toInt() < 0 || value.toInt() >= dates.length) {
            return const SizedBox.shrink();
          }
          final date = dates[value.toInt()];
          final formattedDate = DateFormat('MM/dd').format(date);
          return Text(
            formattedDate,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          );
        },
        interval: 1,
      ),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}