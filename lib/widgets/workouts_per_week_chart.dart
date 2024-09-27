import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_metrics/utils/chart_utils.dart';

class WorkoutsPerWeekChart extends StatelessWidget {
  final List<BarChartGroupData> barGroups;

  const WorkoutsPerWeekChart({Key? key, required this.barGroups})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroups = List.generate(8, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index + 1) *
                2.0, // Example data, replace with actual workout counts
            color: Colors.blueAccent,
          ),
        ],
      );
    });

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
                1),
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
