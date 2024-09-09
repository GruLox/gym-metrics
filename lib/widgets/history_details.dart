import 'package:flutter/material.dart';

class HistoryDetails extends StatelessWidget {
  final int duration;
  final int totalWeightLifted;
  final int prs;

  const HistoryDetails({
    super.key,
    required this.duration,
    required this.totalWeightLifted,
    required this.prs,
  });

  String durationToString(int durationInMinutes) {
    final int hours = durationInMinutes ~/ 60;
    final int minutes = durationInMinutes % 60;
    return '${hours.toString()}h ${minutes.toString()}m';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.schedule, color: Colors.grey),
        const SizedBox(width: 5.0),
        Text(
          durationToString(duration),
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(Icons.monitor_weight_outlined, color: Colors.grey),
        const SizedBox(width: 5.0),
        Text(
          '$totalWeightLifted kg',
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(Icons.emoji_events_outlined, color: Colors.grey),
        const SizedBox(width: 5.0),
        Text(
          '${prs.toString()} PRs',
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
