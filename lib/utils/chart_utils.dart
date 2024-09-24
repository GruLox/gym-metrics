import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

FlGridData buildGridData() {
  return FlGridData(
    show: true,
    drawVerticalLine: true,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: Colors.grey.withOpacity(0.2),
        strokeWidth: 1,
      );
    },
    getDrawingVerticalLine: (value) {
      return FlLine(
        color: Colors.grey.withOpacity(0.2),
        strokeWidth: 1,
      );
    },
  );
}

FlTitlesData buildTitlesData({required double interval, required double minY, required double maxY}) {
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
        getTitlesWidget: (value, meta) => Text(
          '${value.toInt()}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        interval: 1,
      ),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );
}
