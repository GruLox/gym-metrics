import 'package:flutter/material.dart';

class HistoryDetails extends StatelessWidget {
  final String duration;
  final String weight;
  final String prs;

  const HistoryDetails({
    super.key,
    required this.duration,
    required this.weight,
    required this.prs,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.schedule, color: Colors.grey),
        const SizedBox(width: 5.0),
        Text(
          duration,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(Icons.monitor_weight_outlined, color: Colors.grey),
        const SizedBox(width: 5.0),
        Text(
          weight,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(Icons.emoji_events_outlined, color: Colors.grey),
        const SizedBox(width: 5.0),
        Text(
          prs,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}