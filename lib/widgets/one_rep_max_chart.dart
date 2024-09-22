import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OneRepMaxChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const OneRepMaxChart({Key? key, required this.dataPoints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.blue],
            ),
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}