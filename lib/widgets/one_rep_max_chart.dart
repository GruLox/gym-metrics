import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_metrics/utils/chart_utils.dart';

class OneRepMaxChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  const OneRepMaxChart({Key? key, required this.dataPoints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double minYValue =
        dataPoints.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    final double minY =
        minYValue - (minYValue * 0.1); // Add 10% space below the minimum value
    final double maxYValue =
        dataPoints.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    final double maxY =
        maxYValue + (maxYValue * 0.1); // Add 10% space above the maximum value

    return LineChart(
      LineChartData(
        minY: minY,
        maxY: maxY,
        gridData: buildGridData(),
        titlesData: buildTitlesData(interval: 5, minY: minY, maxY: maxY),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blueAccent.withOpacity(0.3),
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 4,
                color: Colors.blueAccent,
                strokeWidth: 2,
                strokeColor: Colors.white,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) =>
                Colors.blueAccent.withOpacity(0.8),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                return LineTooltipItem(
                  '${touchedSpot.y.toInt()} kg',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
          touchCallback: (FlTouchEvent event, LineTouchResponse? response) {},
          handleBuiltInTouches: true,
        ),
      ),
    );
  }
}
