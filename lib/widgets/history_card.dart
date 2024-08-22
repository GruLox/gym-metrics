import 'package:flutter/material.dart';
import 'package:gym_metrics/models/history_data.dart';
import 'package:gym_metrics/widgets/history_details.dart';

class HistoryCard extends StatelessWidget {
  final HistoryData data;

  const HistoryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5.0),
          Text(
            data.title,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5.0),
          Text(
            data.date,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5.0),
          HistoryDetails(
            duration: data.duration,
            weight: data.weight,
            prs: data.prs,
          ),
        ],
      ),
    );
  }
}